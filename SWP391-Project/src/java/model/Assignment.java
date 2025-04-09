/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author hungd
 */
public class Assignment {

    private int assign_id;
    private int subjectID;
    private String assign_name;
    private String assign_descript;
    private int is_active;
    private Timestamp create_at;
    private String part;
    private String weight;
    private String due_date;

    public Assignment() {
    }

    public Assignment(int subjectID, String assign_name, String assign_descript, String part, String weight, String due_date) {
        this.subjectID = subjectID;
        this.assign_name = assign_name;
        this.assign_descript = assign_descript;
        this.part = part;
        this.weight = weight;
        this.due_date = due_date;
    }

  

    public Assignment(int assign_id, int subjectID, String assign_name, String assign_descript, int is_active, Timestamp create_at, String part, String weight, String due_date) {
        this.assign_id = assign_id;
        this.subjectID = subjectID;
        this.assign_name = assign_name;
        this.assign_descript = assign_descript;
        this.is_active = is_active;
        this.create_at = create_at;
        this.part = part;
        this.weight = weight;
        this.due_date = due_date;
    }

    public int getAssign_id() {
        return assign_id;
    }

    public void setAssign_id(int assign_id) {
        this.assign_id = assign_id;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getAssign_name() {
        return assign_name;
    }

    public void setAssign_name(String assign_name) {
        this.assign_name = assign_name;
    }

    public String getAssign_descript() {
        return assign_descript;
    }

    public void setAssign_descript(String assign_descript) {
        this.assign_descript = assign_descript;
    }

    public int getIs_active() {
        return is_active;
    }

    public void setIs_active(int is_active) {
        this.is_active = is_active;
    }

    public Timestamp getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Timestamp create_at) {
        this.create_at = create_at;
    }

    public String getPart() {
        return part;
    }

    public void setPart(String part) {
        this.part = part;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getDue_date() {
        return due_date;
    }

    public void setDue_date(String due_date) {
        this.due_date = due_date;
    }

    @Override
    public String toString() {
        return "Assignment{" + "assign_id=" + assign_id + ", subjectID=" + subjectID + ", assign_name=" + assign_name + ", assign_descript=" + assign_descript + ", is_active=" + is_active + ", create_at=" + create_at + ", part=" + part + ", weight=" + weight + ", due_date=" + due_date + '}';
    }

}
