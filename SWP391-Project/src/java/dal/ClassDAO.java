/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import enums.UserRole;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AssignClass;
import model.Class;
import model.Setting;
import model.User;
import model.Subject;

/**
 *
 * @author Đàm Quang Chiến
 */
public class ClassDAO extends DBConnect {

    public List<AssignClass> paginateClass(int index, int role, int userId) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;

        List<AssignClass> list = new ArrayList<>();
        String sql = "";
        if (role == admin.getValue()) {
            sql = "SELECT * FROM `swp391-spp`.class join subject on class.subject_id = subject.subject_id join system_setting on system_setting.setting_id = class.semester_id  where status =1 limit 10 offset ?";
        } else if (role == subjectManager.getValue()) {
            sql = "SELECT * FROM `swp391-spp`.class join subject on class.subject_id = subject.subject_id join system_setting on system_setting.setting_id = class.semester_id  where status =1 and subject.manager_id = " + userId + " limit 10 offset ?";
        } else {
            sql = "SELECT * FROM `swp391-spp`.class join subject on class.subject_id = subject.subject_id join system_setting on system_setting.setting_id = class.semester_id where manager_id = " + userId + " and status =1 limit 10 offset ? ";
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                AssignClass assignClass = new AssignClass();
                assignClass.setClassId(rs.getInt("class_id"));
                assignClass.setClassCode(rs.getString("class_code"));
                assignClass.setClassDetail(rs.getString("class_details"));
                assignClass.setSemester(rs.getInt("semester_id"));
                assignClass.setSubject(rs.getInt("subject_id"));
                assignClass.setManager(rs.getInt("manager_id"));
                assignClass.setStatus(rs.getInt("status"));
                assignClass.setGitLabId(rs.getString("gitlab_id"));
                assignClass.setAccessToken(rs.getString("access_token"));
                assignClass.setSemesterName(rs.getString("setting_name"));
                assignClass.setSubjectName(rs.getString("subject_name"));

                list.add(assignClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<Class> getAllClasses() {
        
        List<Class> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391-spp`.class where status = 1";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Class c = new Class();
                c.setClassId(rs.getInt("class_id"));
                c.setClassCode(rs.getString("class_code"));
                c.setGitlabId(rs.getString("gitlab_id"));
                c.setAccessToken(rs.getString("access_token"));

                list.add(c);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }
    
    public Class getClassCode(){
        String sql= "select class_id, class_code,semester_id,subject_id, manager_id, status from class";
        ResultSet rs= getData(sql);
        try{
            while(rs.next()){
                int classId =rs.getInt(1);
                String classCode = rs.getString(2);
                int semesterId = rs.getInt(3);
                int subjectId = rs.getInt(4);
                int managerId = rs.getInt(5);
                int status = rs.getInt(6);
                Class cl = new Class(classId,classCode,semesterId,subjectId,managerId,status);
                return cl;
            }
        }catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public Class getClassCodeById(int id){
        String sql= "select class_id, class_code,semester_id,subject_id, manager_id, status from class where class_id ="+id;
        ResultSet rs= getData(sql);
        try{
            while(rs.next()){
                int classId =rs.getInt(1);
                String classCode = rs.getString(2);
                int semesterId = rs.getInt(3);
                int subjectId = rs.getInt(4);
                int managerId = rs.getInt(5);
                int status = rs.getInt(6);
                Class cl = new Class(classId,classCode,semesterId,subjectId,managerId,status);
                return cl;
            }
        }catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    

    public List<AssignClass> filterClass(int index, int role, int userId, String filType, int value) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;

        List<AssignClass> list = new ArrayList<>();
        String sql = "";
        if (role == admin.getValue()) {
            sql = "SELECT * FROM `swp391-spp`.class "
                    + "JOIN subject ON class.subject_id = subject.subject_id "
                    + "JOIN system_setting ON system_setting.setting_id = class.semester_id "
                    + "WHERE status = 1 "
                    + " AND "+filType+" = ? "
                    + "LIMIT 10 OFFSET ?";
        } else if (role == subjectManager.getValue()) {
            sql = "SELECT * FROM `swp391-spp`.class "
                    + "JOIN subject ON class.subject_id = subject.subject_id "
                    + "JOIN system_setting ON system_setting.setting_id = class.semester_id "
                    + "WHERE status = 1 "
                    + "AND subject.manager_id = " + userId + " "
                    + "AND "+filType+" = ? "
                    + "LIMIT 10 OFFSET ?";
        } else {
            sql = "SELECT * FROM `swp391-spp`.class "
                    + "JOIN subject ON class.subject_id = subject.subject_id "
                    + "JOIN system_setting ON system_setting.setting_id = class.semester_id "
                    + "WHERE class.manager_id = " + userId + " "
                    + "AND status = 1 "
                    + "AND "+filType+" = ? "
                    + "LIMIT 10 OFFSET ?";
        }

        try ( PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, value);
            pre.setInt(2, (index - 1) * 10);

            try ( ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    AssignClass assignClass = new AssignClass();
                    assignClass.setClassId(rs.getInt("class_id"));
                    assignClass.setClassCode(rs.getString("class_code"));
                    assignClass.setClassDetail(rs.getString("class_details"));
                    assignClass.setSemester(rs.getInt("semester_id"));
                    assignClass.setSubject(rs.getInt("subject_id"));
                    assignClass.setManager(rs.getInt("manager_id"));
                    assignClass.setStatus(rs.getInt("status"));
                    assignClass.setGitLabId(rs.getString("gitlab_id"));
                    assignClass.setAccessToken(rs.getString("access_token"));
                    assignClass.setSemesterName(rs.getString("setting_name"));
                    assignClass.setSubjectName(rs.getString("subject_name"));
                    list.add(assignClass);
                }
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public List<AssignClass> searchAndPaginateClass(int index, int role, int userId, String searchValue) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;

        List<AssignClass> list = new ArrayList<>();
        String sql = "";
        if (role == admin.getValue()) {
            sql = "SELECT * FROM `swp391-spp`.class "
                    + "JOIN subject ON class.subject_id = subject.subject_id "
                    + "JOIN system_setting ON system_setting.setting_id = class.semester_id "
                    + "WHERE status = 1 "
                    + "AND (class.class_code LIKE ? OR subject.subject_name LIKE ? OR system_setting.setting_name LIKE ?) "
                    + "LIMIT 10 OFFSET ?";
        } else if (role == subjectManager.getValue()) {
            sql = "SELECT * FROM `swp391-spp`.class "
                    + "JOIN subject ON class.subject_id = subject.subject_id "
                    + "JOIN system_setting ON system_setting.setting_id = class.semester_id "
                    + "WHERE status = 1 "
                    + "AND subject.manager_id = " + userId + " "
                    + "AND (class.class_code LIKE ? OR subject.subject_name LIKE ? OR system_setting.setting_name LIKE ?) "
                    + "LIMIT 10 OFFSET ?";
        } else {
            sql = "SELECT * FROM `swp391-spp`.class "
                    + "JOIN subject ON class.subject_id = subject.subject_id "
                    + "JOIN system_setting ON system_setting.setting_id = class.semester_id "
                    + "WHERE class.manager_id = " + userId + " "
                    + "AND status = 1 "
                    + "AND (class.class_code LIKE ? OR subject.subject_name LIKE ? OR system_setting.setting_name LIKE ?) "
                    + "LIMIT 10 OFFSET ?";
        }

        try ( PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, "%" + searchValue + "%");
            pre.setString(2, "%" + searchValue + "%");
            pre.setString(3, "%" + searchValue + "%");
            pre.setInt(4, (index - 1) * 10);

            try ( ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    AssignClass assignClass = new AssignClass();
                    assignClass.setClassId(rs.getInt("class_id"));
                    assignClass.setClassCode(rs.getString("class_code"));
                    assignClass.setClassDetail(rs.getString("class_details"));
                    assignClass.setSemester(rs.getInt("semester_id"));
                    assignClass.setSubject(rs.getInt("subject_id"));
                    assignClass.setManager(rs.getInt("manager_id"));
                    assignClass.setStatus(rs.getInt("status"));
                    assignClass.setGitLabId(rs.getString("gitlab_id"));
                    assignClass.setAccessToken(rs.getString("access_token"));
                    assignClass.setSemesterName(rs.getString("setting_name"));
                    assignClass.setSubjectName(rs.getString("subject_name"));

                    list.add(assignClass);
                }
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public int getTotalClass(int role, int userId) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;

        try {
            String sql = "";
            if (role == admin.getValue() || role == subjectManager.getValue()) {
                sql = "SELECT COUNT(*) FROM class where status = 1";
            } else {
                sql = "SELECT COUNT(*) FROM class WHERE manager_id = ? and status = 1";
            }

            PreparedStatement pre = connection.prepareStatement(sql);

            if (role != admin.getValue() && role != subjectManager.getValue()) {
                pre.setInt(1, userId);
            }

            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return 0;
    }

    public AssignClass getClassInfor(int classId) {
        String sql = "select * from class where class_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classId);
            AssignClass assignClass = new AssignClass();

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                assignClass.setClassId(rs.getInt("class_id"));
                assignClass.setClassCode(rs.getString("class_code"));
                assignClass.setClassDetail(rs.getString("class_details"));
                assignClass.setSemester(rs.getInt("semester_id"));
                assignClass.setSubject(rs.getInt("subject_id"));
                assignClass.setManager(rs.getInt("manager_id"));
                assignClass.setStatus(rs.getInt("status"));
                assignClass.setAccessToken(rs.getString("access_token"));
                assignClass.setGitLabId(rs.getString("gitlab_id"));
            }
            return assignClass;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int updateGitLabMethods(String gitUrl, int classId) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`class`\n"
                + "SET\n"
                + "`gitlab_id` = ?,\n"
                + "WHERE `class_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, gitUrl);
            pre.setInt(2, classId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public List<Class> pagingClass(int index, int role, int userId) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;
        UserRole classManager = UserRole.CLASS_MANAGER;
        List<Class> list = new ArrayList<>();
        String sql = "";
        if(role == admin.getValue()){
            sql="select * from Class limit 10 offset ?";
        }else if(role == subjectManager.getValue()){
            sql="select * from Class inner join subject on class.subject_id =subject.subject_id where subject.manager_id="+userId+" limit 10 offset ?";
        }else if(role == classManager.getValue()){
            sql="select * from Class where manager_id="+userId+" limit 10 offset ?";
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
//            pre.setInt(1,id);
            pre.setInt(1, (index - 1) * 10);
            
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Class(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getInt(7)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalAccount(int role, int userId) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;
        UserRole classManager = UserRole.CLASS_MANAGER;
        String sql = "";
        if(role == admin.getValue()){
            sql="select count(*) from class";
        }else if(role == subjectManager.getValue()){
            sql="select count(*) from Class inner join subject on class.subject_id =subject.subject_id where subject.manager_id="+userId;
        }else if(role == classManager.getValue()){
            sql="select count(*) from Class where manager_id="+userId;
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public List<Class> filter(int role, int userId, String filType, int value) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;
        UserRole classManager = UserRole.CLASS_MANAGER;
        List<Class> list = new ArrayList<>();
        String sql = "";
        if(role == admin.getValue()){
            sql="select * from Class where"+" "+filType+" = ?";
        }else if(role == subjectManager.getValue()){
            sql="select * from Class inner join subject on class.subject_id =subject.subject_id where subject.manager_id="+userId+" and"+" class."+filType+" = ?";
        }else if(role == classManager.getValue()){
            sql="select * from Class where manager_id="+userId+" and"+" "+filType+" = ?";
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
//            pre.setInt(1,id);
            pre.setInt(1, value);
            
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Class(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getInt(7)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> getSemester() {
        List<Setting> list = new ArrayList<>();
        String sql = "select distinct setting_id, setting_group, setting_name, display_order, description, is_active from system_setting where setting_group=1 ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Setting(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Subject> getSubject() {
        List<Subject> list = new ArrayList<>();
        String sql = "select distinct subject.subject_id, subject_code, subject_name, subject.manager_id, subject.is_active from subject ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Subject(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<User> getManager() {
        List<User> list = new ArrayList<>();
        String sql = "select distinct user_id, full_name, email, role_id, is_active from user where role_id=16";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> getSemester1(int role, int userId) {
        List<Setting> list = new ArrayList<>();
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;
        UserRole classManager = UserRole.CLASS_MANAGER;
        String sql = "";
        if(role == admin.getValue()){
            sql="select distinct setting_id, setting_group, setting_name, display_order, description, system_setting.is_active from system_setting inner join class on system_setting.setting_id=semester_id";
        }else if(role == subjectManager.getValue()){
            sql="select distinct setting_id, setting_group, setting_name, display_order, system_setting.description, system_setting.is_active from system_setting inner join class on system_setting.setting_id=semester_id"
                    +" inner join subject on class.subject_id= subject.subject_id where subject.manager_id="+userId;
        }else if(role == classManager.getValue()){
            sql="select distinct setting_id, setting_group, setting_name, display_order, description, system_setting.is_active from system_setting inner join class on system_setting.setting_id=semester_id"
                    +" where manager_id="+userId;
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Setting(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<Subject> getSubject1(int role, int userId) {
        List<Subject> list = new ArrayList<>();
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;
        UserRole classManager = UserRole.CLASS_MANAGER;
        String sql = "";
        if(role == admin.getValue()){
            sql="select distinct subject.subject_id, subject_code, subject_name, subject.manager_id, subject.is_active from subject inner join class on subject.subject_id = class.subject_id";
        }else if(role == subjectManager.getValue()){
            sql="select distinct subject.subject_id, subject_code, subject_name, subject.manager_id, subject.is_active from subject "
                    + "where subject.manager_id="+userId;
        }else if(role == classManager.getValue()){
            sql="select distinct subject.subject_id, subject_code, subject_name, subject.manager_id, subject.is_active from subject inner join class on subject.subject_id = class.subject_id"
                    +" where class.manager_id="+userId;
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Subject(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<User> getManager1(int role, int userId) {
        List<User> list = new ArrayList<>();
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;
        UserRole classManager = UserRole.CLASS_MANAGER;
        String sql = "";
        if(role == admin.getValue()){
            sql="select distinct user_id, full_name, email, role_id, user.is_active from user inner join class on user_id=manager_id";
        }else if(role == subjectManager.getValue()){
            sql="select distinct user_id, full_name, email, role_id, user.is_active from user inner join class on user_id=manager_id"
                    + " inner join subject on class.subject_id = subject.subject_id where subject.manager_id="+userId;
        }else if(role == classManager.getValue()){
            sql="select distinct user_id, full_name, email, role_id, user.is_active from user inner join class on user_id=manager_id"
                    +" where class.manager_id="+userId;
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public int ClassStatusChange(int id, int status) {
        int result = 0;
        String sql = "UPDATE `swp391-spp`.`class`\n"
                + "SET\n"
                + "`status` = ?\n"
                + "WHERE `class_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, id);
            result = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public int delete(int id) {
        int n = 0;
        try {
            Statement state = connection.createStatement();
            n = state.executeUpdate("delete from `swp391-spp`.`class_student`WHERE class_id=" + id);
            n = state.executeUpdate("delete from `swp391-spp`.`class`WHERE class_id=" + id);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }

    public List<Class> search(int role, int userId, String name) {
        List<Class> list = new ArrayList<>();
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;
        UserRole classManager = UserRole.CLASS_MANAGER;
        String sql="";
        if(role == admin.getValue()){
            sql="select class_id, class_code, semester_id,subject_id,manager_id,status from class where class_id like '" + name + "%' or class_code like '%" + name + "%'";
        }else if(role == subjectManager.getValue()){
            sql="select class.class_id, class.class_code, class.semester_id, class.subject_id, class.manager_id, status from class inner join subject"
            +" on class.subject_id = subject.subject_id where subject.manager_id ="+userId+" and (class.class_id like '" + name + "%' or class.class_code like '%" + name + "%')";
        }else if(role == classManager.getValue()){
            sql="select class_id, class_code, semester_id,subject_id,manager_id,status from class where manager_id="+userId+" and (class.class_id like '" + name + "%' or class.class_code like '%" + name + "%')";
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Class(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public int insertClass(Class cl) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`class`\n"
                + " (`class_code`,\n"
                + " `semester_id`,\n"
                + " `subject_id`,\n"
                + " `manager_id`,\n"
                + " `status`,\n"
                + " `gitlab_id`)\n"
                + " VALUES(?,?,?,?,?,?);";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, cl.getClassCode());
            pre.setInt(2, cl.getSemesterId());
            pre.setInt(3, cl.getSubjectId());
            pre.setInt(4, cl.getManagerId());
            pre.setInt(5, cl.getStatus());
            pre.setString(6, cl.getGitlabId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public int updateClass(Class cl) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`class`\n"
                + "SET\n"
                + "`class_code` = ?,\n"
                + "`semester_id` = ?,\n"
                + "`subject_id` = ?,\n"
                + "`manager_id` = ?,\n"
                + "`status` = ?,\n"
                + "`gitlab_id` = ?,\n" 
                + "`class_details` = ?,\n"
                + "`access_token` = ?\n"
                + "WHERE `class_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, cl.getClassCode());
            pre.setInt(2, cl.getSemesterId());
            pre.setInt(3, cl.getSubjectId());
            pre.setInt(4, cl.getManagerId());
            pre.setInt(5, cl.getStatus());
            pre.setString(6, cl.getGitlabId());
            pre.setString(7, cl.getClassDetails());
            pre.setString(8, cl.getAccessToken());
            pre.setInt(9, cl.getClassId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public Vector getClass(String sql) {
        Vector<Class> vector = new Vector<Class>();
        try {
            Statement state = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                //dataType varName=rs.getDataType(fieldName|index);
                int cid = rs.getInt(1); // int pid=rs.getInt("productID");
                String code = rs.getString(2);//String pname=rs.getString(2);
                int semester = rs.getInt(4);
                int subject = rs.getInt(5);
                int manager = rs.getInt(6);
                int status = rs.getInt(7);
                String gitlab = rs.getString(12);
                String details = rs.getString(3);
                String acctoken = rs.getString(13);
                Class cl = new Class(cid, code, details, semester, subject, manager, status, gitlab,acctoken);
                vector.add(cl);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return vector;
    }
    
    public boolean checkClassExisted(int classId) {
        String sql = "SELECT count(*) FROM `swp391-spp`.class where class_id =?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, classId);
            ResultSet result = st.executeQuery();

            if (result.next()) {
                int count = result.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking existence: " + e);
        }

        return false; // No matching records found
    }

    public static void main(String[] args) {
        ClassDAO dao = new ClassDAO();
        List<AssignClass> list = dao.filterClass(1, 14, 1, "semester_id", 20);
        System.out.println("list size: "+list.size());
        for (AssignClass c : list) {
            System.out.println(c);
        }
    }
}
