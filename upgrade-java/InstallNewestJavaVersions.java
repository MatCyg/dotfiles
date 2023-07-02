import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class InstallNewestJavaVersions {
    private static final Pattern p = Pattern.compile(".*\\|\\s*(.*)\\|\\s*(.*)");

    public static void main(String[] args) throws IOException, InterruptedException {
        Map<String, List<SemVersion>> collect = SdkMan.listJava()
                .filter(s -> s.contains("-graalce") | s.contains("-tem"))
                .map(s -> s.replace(" ", ""))
                .map(p::matcher)
                .filter(Matcher::find)
                .map(m -> SemVersion.of(m.group(2), Status.from(m.group(1))))
                .collect(Collectors.groupingBy(SemVersion::type));

        List<SemVersion> javaVersions = collect.get("tem").stream()
                .map(SemVersion::major)
                .distinct()
                .flatMap(major -> collect.get("tem")
                        .stream()
                        .filter(v -> major == v.major())
                        .filter(v -> v.status() != Status.LOCAL_ONLY)
                        .max(SemVersion::compareTo)
                        .stream())
                .toList();

        List<SemVersion> grlVersions = collect.get("graalce").stream()
                .mapToInt(SemVersion::major)
                .max()
                .stream()
                .mapToObj(major -> collect.get("graalce")
                        .stream()
                        .filter(v -> major == v.major())
                        .filter(v -> v.status() != Status.LOCAL_ONLY)
                        .max(SemVersion::compareTo))
                .flatMap(Optional::stream)
                .toList();


        List<SemVersion> shouldBeInstalled =
                Stream.concat(javaVersions.stream(), grlVersions.stream()).toList();

        List<SemVersion> toDelete = collect.values()
                .stream()
                .flatMap(List::stream)
                .filter(v -> v.status() != Status.REMOTE)
                .filter(v -> !shouldBeInstalled.contains(v))
                .collect(Collectors.toList());

        List<SemVersion> toInstall = shouldBeInstalled.stream()
                .filter(v -> v.status() != Status.INSTALLED)
                .toList();


        if (toDelete.isEmpty() && toInstall.isEmpty()) {
            System.out.println("Everything up to date, exiting...");
            System.exit(0);
        }

        System.out.print("###################################\nJava versions to install:\n");
        toInstall.forEach(System.out::println);

        System.out.print("###################################\nJava versions to uninstall:\n");
        toDelete.forEach(System.out::println);


        System.out.println("Do you want to continue? [y/n]");
        String response = new Scanner(System.in).nextLine();
        if (response.equalsIgnoreCase("y")) {
            SdkMan.installJava(toInstall);
            SdkMan.uninstallJava(toDelete);
        } else {
            System.err.println("Aborted");
            System.exit(1);
        }
    }

    static class SdkMan {

        private static Process execute(String cmd) throws IOException {
            String commandToExecute = "source $HOME/.sdkman/bin/sdkman-init.sh && sdk " + cmd;
            return Runtime.getRuntime().exec(new String[]{"bash", "-c", commandToExecute});
        }

        private static Stream<String> listJava() throws IOException {
            Process process = execute("list java");
            return new BufferedReader(new InputStreamReader(process.getInputStream())).lines();
        }

        private static void uninstallJava(List<SemVersion> semVersions) throws IOException, InterruptedException {
            for (SemVersion semVersion : semVersions) {
                System.out.printf("Removing %s ...\n", semVersion.identifier());
                Process process = execute("uninstall java " + semVersion.identifier());
                process.getInputStream().transferTo(System.out);
                process.getErrorStream().transferTo(System.out);
                if (process.waitFor() == 0) {
                    System.out.printf("Removed %s ...\n", semVersion.identifier());
                }
            }
        }

        private static void installJava(List<SemVersion> semVersions) throws IOException, InterruptedException {
            for (SemVersion semVersion : semVersions) {
                System.out.printf("Installing %s ...\n", semVersion.identifier());
                Process process = execute("install java " + semVersion.identifier());
                process.getInputStream().transferTo(System.out);
                process.getErrorStream().transferTo(System.out);
                if (process.waitFor() == 0) {
                    System.out.printf("Installed %s ...\n", semVersion.identifier());
                }
            }
        }
    }


    enum Status {
        INSTALLED, LOCAL_ONLY, REMOTE;

        public static Status from(String s) {
            return switch (s) {
                case "installed" -> INSTALLED;
                case "localonly" -> LOCAL_ONLY;
                default -> REMOTE;
            };
        }
    }

    record SemVersion(String identifier, int major, int minor, int patch, int hotfix, String type, Status status)
            implements Comparable<SemVersion> {

        static SemVersion of(String identifier, Status status) {
            var verSplit = identifier.split("-");
            var semVer = verSplit[0].split("\\.");
            var type = verSplit[1];
            return new SemVersion(identifier, intAt(semVer, 0), intAt(semVer, 1), intAt(semVer, 2), intAt(semVer, 3), type, status);
        }

        private static Integer intAt(String[] split, int pos) {
            return Optional.of(split)
                    .filter(arr -> arr.length >= pos + 1)
                    .map(arr -> arr[pos])
                    .filter(s -> s.chars().allMatch(Character::isDigit))
                    .map(Integer::parseInt)
                    .orElse(0);
        }

        @Override
        public int compareTo(SemVersion b) {
            return major - b.major + minor - b.minor + patch - b.patch + hotfix - b.hotfix;
        }

        @Override
        public String toString() {
            return identifier;
        }
    }
}