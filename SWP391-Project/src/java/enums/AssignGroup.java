/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package enums;

/**
 *
 * @author Đàm Quang Chiến
 */
public enum AssignGroup {
    SUBJECT(1),
    CLASS(2),
    PROJECT(3);

    private final int value;

    AssignGroup(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
