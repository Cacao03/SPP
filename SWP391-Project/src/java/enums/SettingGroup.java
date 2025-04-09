package enums;

public enum SettingGroup {
    SEMESTER(1, "Semester Settings", "Settings related to the current semester"),
    USER_ROLE(2, "User Role Settings", "Settings related to user roles"),
    PERMITTED_EMAIL(3, "Permitted Email Settings", "Settings related to permitted email addresses");

    private final int value;
    private final String displayName;
    private final String description;

    SettingGroup(int value, String displayName, String description) {
        this.value = value;
        this.displayName = displayName;
        this.description = description;
    }

    public int getValue() {
        return value;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getDescription() {
        return description;
    }

    public static void main(String[] args) {
        SettingGroup setting = SettingGroup.SEMESTER;
        System.out.println("Name: " + setting.name()); // Output: SEMESTER
        System.out.println("Value: " + setting.getValue()); // Output: 1
        System.out.println("Display Name: " + setting.getDisplayName()); // Output: Semester Settings
        System.out.println("Description: " + setting.getDescription()); // Output: Settings related to the current semester

    }
}
