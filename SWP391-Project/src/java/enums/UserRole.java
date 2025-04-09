/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package enums;

/**
 *
 * @author Đàm Quang Chiến
 */
public enum UserRole {
    ADMIN(14),
    SUBJECT_MANAGER(15),
    CLASS_MANAGER(16),
    PROJECT_MENTOR(18),
    STUDENT(19);

    private final int value;

    UserRole(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
