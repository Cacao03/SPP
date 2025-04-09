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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Assignment;
import model.IssueSetting;
import model.Subject;
import model.User;

/**
 *
 * @author hungd
 */
public class SubjectDAO extends DBConnect {

    public ResultSet listAll() {
        String sql = "select * from subject";
        ResultSet rs = getData(sql);
        return rs;
    }

    public int insertSubject(Subject sub) {
        int n = 0;
        String sql = "INSERT INTO subject(subject_code,subject_name,manager_id,is_active, description) "
                + "VALUES (?,?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, sub.getSubjectCode());
            pre.setString(2, sub.getSubjectName());
            pre.setInt(3, sub.getManagerID());
            pre.setInt(4, sub.getIsActive());
            pre.setString(5, sub.getDescription());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int updateSubject(Subject sub) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`subject`\n"
                + "SET\n"
                + "`subject_code` = ?,\n"
                + "`subject_name` = ?,\n"
                + "`manager_id` = ?,\n"
                + "`is_active` = ?,\n"
                + "`description` = ?\n"
                + "WHERE `subject_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, sub.getSubjectCode());
            pre.setString(2, sub.getSubjectName());
            pre.setInt(3, sub.getManagerID());
            pre.setInt(4, sub.getIsActive());
            pre.setString(5, sub.getDescription());
            pre.setInt(6, sub.getSubjectId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public Subject getSubjectById3(String id) {
        String sql = "select * from subject where subject_id =" + id + "";
        try {
            Statement state = connection.createStatement();
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                Subject sub = new Subject(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
                return sub;
            }

        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet getSubjectById2(String id) {
        String sql = "select * from subject where subject_id =" + id;
        ResultSet rs = getData(sql);
        return rs;
    }

    public Vector getSubject(String sql) {
        Vector<Subject> vector = new Vector<Subject>();

        try {
            Statement state = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int subjectId = rs.getInt(1);
                String subjectCode = rs.getString(2);
                String subjectName = rs.getString(3);
                int managerID = rs.getInt(4);
                int isActive = rs.getInt(5);
                Timestamp updateAt = rs.getTimestamp(9);
                Subject sub = new Subject(subjectId, subjectCode, subjectName, managerID, isActive, updateAt);
                vector.add(sub);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public List<Subject> pagingSubject(int index, int role, int managerID) {
        List<Subject> list = new ArrayList<>();

        try {
            String sql = "";
            if (role == 14) {
                sql = "select * from subject limit 10 offset ?";
                PreparedStatement pre = connection.prepareStatement(sql);

                pre.setInt(1, (index - 1) * 10);
                ResultSet rs = pre.executeQuery();
                while (rs.next()) {
                    list.add(new Subject(
                            rs.getInt("subject_id"),
                            rs.getString("subject_code"),
                            rs.getString("subject_name"),
                            rs.getInt("manager_id"),
                            rs.getInt("is_active"),
                            rs.getTimestamp("update_at")
                    ));
                }
            } else if (role == 15) {
                sql = "select * from subject where manager_id = ? limit 10 offset ?";
                PreparedStatement pre = connection.prepareStatement(sql);
                pre.setInt(1, managerID);
                pre.setInt(2, (index - 1) * 10);
                ResultSet rs = pre.executeQuery();
                while (rs.next()) {
                    list.add(new Subject(
                            rs.getInt("subject_id"),
                            rs.getString("subject_code"),
                            rs.getString("subject_name"),
                            rs.getInt("manager_id"),
                            rs.getInt("is_active"),
                            rs.getTimestamp("update_at")
                    ));
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<User> getName() {
        List<User> list = new ArrayList<>();
        String sql = "select distinct user_id, full_name, role_id from user inner join subject on user_id = manager_id";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalAccount(int managerID, int role) {
        String sql = "";
        try {
            if (role == 14) {
                sql = "select count(*) from subject";

            } else if (role == 15) {
                sql = "select count(*) from subject where manager_id = ?";
            }
            PreparedStatement pre = connection.prepareStatement(sql);
            if (role == 15) {
                pre.setInt(1, managerID);
            }
            ResultSet rs = pre.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalSubject(int role, int userId) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;

        try {
            String sql = "";
            if (role == admin.getValue()) {
                sql = "SELECT COUNT(*) FROM subject";
            } else {
                sql = "SELECT COUNT(*) FROM subject WHERE manager_id = ?";
            }

            PreparedStatement pre = connection.prepareStatement(sql);

            if (role != admin.getValue() && role == subjectManager.getValue()) {
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

    public int searchSubject(int role, int userId) {
        UserRole admin = UserRole.ADMIN;
        UserRole subjectManager = UserRole.SUBJECT_MANAGER;

        try {
            String sql = "";
            if (role == admin.getValue()) {
                sql = "select subject_id, subject_code, subject_name, is_active from subject";
            } else {
                sql = "select subject_id, subject_code, subject_name, is_active from subject where manager_id = ?";
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

    public Vector getField(String name) {
        Vector<String> vector = new Vector<String>();
        ResultSet rs = this.getData("select distinct " + name + " from subject");
        try {
            while (rs.next()) {
                vector.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

//    public ResultSet searchSubByCode(String searchValue) {
//        String sql = "SELECT rs.subject_id, rs.subject_code, rs.subject_name, rs.manager_id, rs.is_active, rs.update_at, rs.full_name "
//                + "FROM (SELECT s.subject_id, s.subject_code, s.subject_name, s.manager_id, s.is_active, s.update_at, u.full_name FROM subject s INNER JOIN user u "
//                + "ON s.manager_id = u.user_id WHERE u.role_id = 15) rs WHERE rs.full_name LIKE '%" + searchValue + "%' or rs.subject_code like '%" + searchValue + "%' or rs.subject_name like '%" + searchValue + "%'";
//        ResultSet rs = getData(sql);
//        return rs;
//    }
    public List<Subject> searchSubject(int index, String searchValue) {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM subject s INNER JOIN user u ON user_id= manager_id WHERE s.subject_code LIKE '%" + searchValue + "%' or s.subject_name '" + searchValue + "%' or u.full_name like '%" + searchValue + "%' limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Subject(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(11),
                        rs.getInt(9),
                        rs.getTimestamp(5)));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
//    public ResultSet checkActive(String is_active) {
//        ResultSet rs = null;
//        String sql = "SELECT rs.subject_id, rs.subject_code, rs.subject_name, rs.manager_id, rs.is_active, rs.update_at, rs.full_name "
//                + "FROM (SELECT s.subject_id, s.subject_code, s.subject_name, s.manager_id, s.is_active, s.update_at, u.full_name FROM subject s INNER JOIN user u "
//                + "ON s.manager_id = u.user_id WHERE u.role_id = 15) rs WHERE rs.is_active LIKE '%" + is_active + "%'";
//        rs = getData(sql);
//        return rs;
//    }

    public int SubjectStatusChange(int id, int status) {
        int result = 0;
        String sql = "UPDATE `swp391-spp`.`subject`\n"
                + "SET\n"
                + "`is_active` = ?\n"
                + "WHERE `subject_id` = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, id);

            result = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public boolean isSubjectCodeDuplicate(String subjectCode) {
        String query = "select count(*) from subject where subject_code = ?";
        try (
                 PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, subjectCode);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkDulicate(String subjectCode) {
        String query = "SELECT subject_code FROM subject where subject_code = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, subjectCode);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalAssignment(int subjectID) {
        String sql = "select count(*) from assignment where subject_id = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            ResultSet rs = pre.executeQuery();  // Change this line
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalSubjectSetting(int subjectID) {
        String sql = "select count(*) from issue_setting where subject_id = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            ResultSet rs = pre.executeQuery();  // Change this line
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalIssueSetting() {
        String sql = "select count(*) from issue_setting";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Assignment> pagingAssignment(int subjectID, int index) {
        List<Assignment> list = new ArrayList<>();
        String sql = "select * from assignment where subject_id = ? limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            pre.setInt(2, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Assignment ass = new Assignment();
                ass.setSubjectID(rs.getInt("subject_id"));
                ass.setAssign_id(rs.getInt("assign_id"));
                ass.setAssign_name(rs.getString("assign_name"));
                ass.setAssign_descript(rs.getString("assign_descript"));
                ass.setIs_active(rs.getInt("is_active"));
                ass.setCreate_at(rs.getTimestamp("created_at"));
                ass.setPart(rs.getString("part"));
                ass.setWeight(rs.getString("weight"));
                ass.setDue_date(rs.getString("due_date"));
                list.add(ass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Assignment pagingAssignment2(int subjectID, int index) {

        String sql = "select * from assignment where subject_id = ? limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            pre.setInt(2, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Assignment ass = new Assignment();
                ass.setSubjectID(rs.getInt("subject_id"));
                ass.setAssign_id(rs.getInt("assign_id"));
                ass.setAssign_name(rs.getString("assign_name"));
                ass.setAssign_descript(rs.getString("assign_descript"));
                ass.setIs_active(rs.getInt("is_active"));
                ass.setCreate_at(rs.getTimestamp("created_at"));
                ass.setPart(rs.getString("part"));
                ass.setWeight(rs.getString("weight"));
                ass.setDue_date(rs.getString("due_date"));
                return ass;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<IssueSetting> pagingSubjectSetting(int subjectID, int index) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select * from issue_setting where subject_id = ? limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            pre.setInt(2, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public IssueSetting pagingSubjectSetting2(int subjectID, int index) {

        String sql = "select * from issue_setting where subject_id = ? limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            pre.setInt(2, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                return iss;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Subject> getSubjectDetails(int subjectID) {
        List<Subject> list = new ArrayList<>();
        String sql = "select * from subject where subject_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject sub = new Subject();
                sub.setSubjectId(rs.getInt("subject_id"));
                sub.setSubjectCode(rs.getString("subject_code"));
                sub.setSubjectName(rs.getString("subject_name"));
                sub.setTimeAllocation(rs.getString("time_allocation"));
                sub.setDescription(rs.getString("description"));
                sub.setPassGrade(rs.getInt("pass_grade"));
                sub.setIsActive(rs.getInt("is_active"));
                list.add(sub);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Subject getSubjectDetailsUpdate(String subjectID) {
        String sql = "select * from subject where subject_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, subjectID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Subject sub = new Subject();
                sub.setSubjectId(rs.getInt("subject_id"));
                sub.setSubjectCode(rs.getString("subject_code"));
                sub.setSubjectName(rs.getString("subject_name"));
                sub.setTimeAllocation(rs.getString("time_allocation"));
                sub.setDescription(rs.getString("description"));
                sub.setPassGrade(rs.getInt("pass_grade"));
                sub.setIsActive(rs.getInt("is_active"));
                return sub;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
  
    public List<Assignment> getSubjectAssignment(int subjectID) {
        List<Assignment> list = new ArrayList<>();
        String sql = "select * from assignment where subject_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Assignment ass = new Assignment();
                ass.setSubjectID(rs.getInt("subject_id"));
                ass.setAssign_id(rs.getInt("assign_id"));
                ass.setAssign_name(rs.getString("assign_name"));
                ass.setAssign_descript(rs.getString("assign_descript"));
                ass.setIs_active(rs.getInt("is_active"));
                ass.setCreate_at(rs.getTimestamp("created_at"));
                ass.setPart(rs.getString("part"));
                ass.setWeight(rs.getString("weight"));
                ass.setDue_date(rs.getString("due_date"));
                list.add(ass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Assignment> getListSubjectAssignment(String sql) {
        List<Assignment> list = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Assignment ass = new Assignment();
                ass.setSubjectID(rs.getInt("subject_id"));
                ass.setAssign_id(rs.getInt("assign_id"));
                ass.setAssign_name(rs.getString("assign_name"));
                ass.setAssign_descript(rs.getString("assign_descript"));
                ass.setIs_active(rs.getInt("is_active"));
                ass.setCreate_at(rs.getTimestamp("created_at"));
                ass.setPart(rs.getString("part"));
                ass.setWeight(rs.getString("weight"));
                ass.setDue_date(rs.getString("due_date"));
                list.add(ass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<IssueSetting> getListSubjectSetting(int subjectID) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "SELECT setting_id, subject_id, title, status, description, create_at FROM issue_setting where subject_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));

                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<IssueSetting> getAllIssueType(int subId) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select distinct title from issue_setting where subject_id =?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setTitle(rs.getString("title"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(list.size());
        return list;
    }

    public List<IssueSetting> getAllIssueStatus(int subId) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select distinct status from issue_setting where subject_id =?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setStatus(rs.getString("status"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(list.size());
        return list;
    }

    public List<IssueSetting> listSubjectSettingSearch(String sql) {
        List<IssueSetting> list = new ArrayList<>();

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public IssueSetting getSubjectSetting(int classID) {
        String sql = "SELECT * FROM issue_setting where setting_id = ? ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                return iss;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public IssueSetting getSubjectSettingByID(int subjectID) {
        String sql = "SELECT * FROM issue_setting where subject_id = ? ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                return iss;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int addSubjectSetting(IssueSetting iss) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`issue_setting`\n"
                + "(`subject_id`,\n"
                + "`title`,\n"
                + "`status`,\n"
                + "`description`)\n"
                + "VALUES\n"
                + "(?,?,?,?)";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, iss.getSubject_id());
            pre.setString(2, iss.getTitle());
            pre.setString(3, iss.getStatus());
            pre.setString(4, iss.getDescription());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateSubjectSetting(IssueSetting iss) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`issue_setting`\n"
                + "SET\n"
                + "`title` = ?,\n"
                + "`status` = ?,\n"
                + "`description` = ?\n"
                + "WHERE `setting_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, iss.getTitle());
            pre.setString(2, iss.getStatus());
            pre.setString(3, iss.getDescription());
            pre.setInt(4, iss.getSetting_id());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public List<Assignment> getAssignmentDetails(int assign_id) {
        List<Assignment> list = new ArrayList<>();
        String sql = "select * from assignment where assign_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, assign_id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Assignment ass = new Assignment();
                ass.setSubjectID(rs.getInt("subject_id"));
                ass.setAssign_id(rs.getInt("assign_id"));
                ass.setAssign_name(rs.getString("assign_name"));
                ass.setAssign_descript(rs.getString("assign_descript"));
                ass.setIs_active(rs.getInt("is_active"));
                ass.setCreate_at(rs.getTimestamp("created_at"));
                ass.setPart(rs.getString("part"));
                ass.setWeight(rs.getString("weight"));
                ass.setDue_date(rs.getString("due_date"));
                list.add(ass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Assignment> getAssignmentDetailsByStatus(int subjectId, String status) {
        List<Assignment> list = new ArrayList<>();
        String sql = "select * from assignment where subject_id = ? and is_active = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subjectId);
            pre.setString(2, status);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                // Add the fetched assignment details to the list
            }
        } catch (SQLException ex) {
            // Handle any exceptions
        }
        return list;
    }

    public int addAssignment(Assignment ass) {
        int n = 0;
        String sql = "INSERT INTO assignment(subject_id,assign_name,assign_descript,part,weight,due_date) "
                + "VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, ass.getSubjectID());
            pre.setString(2, ass.getAssign_name());
            pre.setString(3, ass.getAssign_descript());
            pre.setString(4, ass.getPart());
            pre.setString(5, ass.getWeight());
            pre.setString(6, ass.getDue_date());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateAssignment(Assignment ass) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`assignment`\n"
                + " SET\n"
                + " `assign_name` = ?,\n"
                + " `assign_descript` = ?,\n"
                + " `is_active` = ?,\n"
                + " `created_at` = ?,\n"
                + " `part` = ?,\n"
                + " `weight` = ?,\n"
                + " `due_date` = ?\n"
                + " WHERE `assign_id` = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, ass.getAssign_name());
            pre.setString(2, ass.getAssign_descript());
            pre.setInt(3, ass.getIs_active());
            pre.setTimestamp(4, ass.getCreate_at());
            pre.setString(5, ass.getPart());
            pre.setString(6, ass.getWeight());
            pre.setString(7, ass.getDue_date());
            pre.setInt(8, ass.getAssign_id());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int updateSubjectIter2(Subject sub) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`subject`\n"
                + "SET\n"
                + "`subject_code` = ?,\n"
                + "`subject_name` = ?,\n"
                + "`is_active` = ?,\n"
                + "`description` = ?,\n"
                + "`time_allocation` = ?,\n"
                + "`pass_grade` = ?\n"
                + "WHERE `subject_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, sub.getSubjectCode());
            pre.setString(2, sub.getSubjectName());
            pre.setInt(3, sub.getIsActive());
            pre.setString(4, sub.getDescription());
            pre.setString(5, sub.getTimeAllocation());
            pre.setInt(6, sub.getPassGrade());
            pre.setInt(7, sub.getSubjectId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public boolean isAssignmentNameDouble(String assignName) {
        String query = "select count(*) from assignment where assign_name = ?";
        try (
                 PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, assignName);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getManager() {
        List<User> list = new ArrayList<>();
        String sql = "select distinct user_id, full_name, email, role_id, u.is_active from user u join subject s on u.user_id = s.manager_id";
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

    public int deleteAssignmentByID(int id) {
        int n = 0;
        String sql = "DELETE FROM assignment where assign_id =" + id;
        try {
            Statement state = connection.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int AssignmentStatusChange(int id, int status) {
        int result = 0;
        String sql = "UPDATE `swp391-spp`.`assignment` SET `is_active` =" + status + " WHERE `assign_id` =" + id + "";
        try {
            Statement state = connection.createStatement();
            result = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int deleteSettingById(int id) {
        int n = 0;
        String sql = "DELETE FROM issue_setting where setting_id =" + id;
        try {
            Statement state = connection.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public static void main(String[] args) throws SQLException {
        SubjectDAO dao = new SubjectDAO();
        Subject sub = new Subject();
        sub.setSubjectId(1);
        sub.setDescription("asd");
        dao.updateSubjectIter2(sub);
//        int n = dao.AssignmentStatusChange(2, 1);
//        List<IssueSetting> list = dao.getAllIssueType(1);
//        for (IssueSetting iss : list) {
//            System.out.println(iss);
    }
}
