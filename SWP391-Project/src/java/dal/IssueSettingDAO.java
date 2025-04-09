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
import model.IssueSetting;
import model.Project;
import model.Subject;

/**
 *
 * @author Đàm Quang Chiến
 */
public class IssueSettingDAO extends DBConnect {

    public List<IssueSetting> getListSubjectSetting(int subjectID) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "SELECT setting_id, subject_id, title, status, description, create_at, is_active FROM issue_setting where subject_id = ? ";
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
                iss.setIsActive(rs.getInt("is_active"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<IssueSetting> pagingClassIssueSetting(int subId, int clasId, int index) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select setting_id, subject_id, class_id, title, status, description, create_at, is_active FROM issue_setting where subject_id = ? and class_id = ? limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subId);
            pre.setInt(2, clasId);
            pre.setInt(3, (index - 1) * 10);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                iss.setIsActive(rs.getInt("is_active"));

                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<IssueSetting> getListClassSetting(int subjectID, int classID) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "SELECT setting_id, subject_id, class_id, title, status, description, create_at, is_active FROM issue_setting where subject_id = ? and class_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, subjectID);
            pre.setInt(2, classID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                iss.setIsActive(rs.getInt("is_active"));

                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
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
                assignClass.setGitLabId(rs.getString("gitlab_id"));
            }
            return assignClass;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

   

    public List<IssueSetting> getListProjectSetting(int projectID) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "SELECT setting_id, project_id, title, status, description, create_at, is_active FROM issue_setting where project_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, projectID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                iss.setIsActive(rs.getInt("is_active"));

                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(IssueSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
//change status

    public ResultSet getProjectByProjectID(int projectID) {
        ResultSet rs = null;
        String sql = "select * from `swp391-spp`.project where project_id =" + projectID;
        rs = getData(sql);
        return rs;
    }

    public int StatusChange(int id, int status) {
        int result = 0;
        String sql = "UPDATE `swp391-spp`.`issue_setting` SET `is_active` =" + status + " WHERE `setting_id` =" + id + "";
        try {
            Statement state = connection.createStatement();
            result = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public Vector getClass(String sql) {
        Vector<model.Class> vector = new Vector<model.Class>();
        try {
            Statement state = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int cid = rs.getInt(1);
                String code = rs.getString(2);
                int semester = rs.getInt(4);
                int subject = rs.getInt(5);
                int manager = rs.getInt(6);
                int status = rs.getInt(7);
                String gitlab = rs.getString(12);
                String details = rs.getString(3);
                model.Class cl = new model.Class(cid, code, details, semester, subject, manager, status, gitlab, code);
                vector.add(cl);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public Vector getSubject(String sql) {
        Vector<model.Subject> vector = new Vector<model.Subject>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
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
                vector.add(sub);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
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

    public List<IssueSetting> getAllClassIssueType(int subId, int ClasId) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select distinct title from issue_setting where subject_id =? and class_id=?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subId);
            pre.setInt(2, ClasId);
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

    public List<IssueSetting> getAllClassIssueStatus(int subId, int ClasId) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select distinct status from issue_setting where subject_id =? and class_id=?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subId);
            pre.setInt(2, ClasId);
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

    public List<IssueSetting> getAllProjectIssueType(int projectID) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select distinct title from issue_setting where project_id=?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, projectID);
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

    public List<IssueSetting> getAllProjectIssueStatus(int projectID) {
        List<IssueSetting> list = new ArrayList<>();
        String sql = "select distinct status from issue_setting where project_id=?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, projectID);
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

    public IssueSetting getSubjectSetting(int subjectID) {
        String sql = "SELECT * FROM issue_setting where setting_id = ? ";
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
                iss.setIsActive(rs.getInt("is_active"));

                return iss;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public IssueSetting getClassSetting(int settingID, int classID) {
        String sql = "SELECT * FROM issue_setting where setting_id = ? and class_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, settingID);
            pre.setInt(2, classID);
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
                iss.setIsActive(rs.getInt("is_active"));

                return iss;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public IssueSetting getProjectSetting(int settingID, int projectID) {
        String sql = "SELECT * FROM issue_setting where setting_id = ? and project_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, settingID);
            pre.setInt(2, projectID);
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
                iss.setIsActive(rs.getInt("is_active"));

                return iss;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<IssueSetting> searchNFilterSubject(String sql) {
        List<IssueSetting> list = new ArrayList<>();

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                iss.setIsActive(rs.getInt("is_active"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<IssueSetting> searchNFilterProject(String sql) {
        List<IssueSetting> list = new ArrayList<>();

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                iss.setIsActive(rs.getInt("is_active"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<IssueSetting> listSettingSearch(String sql) {
        List<IssueSetting> list = new ArrayList<>();

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setIsActive(rs.getInt("is_active"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public List<IssueSetting> ProjectSettingSearch(String sql) {
        List<IssueSetting> list = new ArrayList<>();

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setProject_id(rs.getInt("project_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setIsActive(rs.getInt("is_active"));
                iss.setDescription(rs.getString("description"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int addClassSetting(IssueSetting iss) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`issue_setting`\n"
                + "(`subject_id`,\n"
                + "`class_id`,\n"
                + "`title`,\n"
                + "`status`,\n"
                + "`description`)\n"
                + "VALUES\n"
                + "(?,?,?,?,?)";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, iss.getSubject_id());
            pre.setInt(2, iss.getClass_id());
            pre.setString(3, iss.getTitle());
            pre.setString(4, iss.getStatus());
            pre.setString(5, iss.getDescription());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int addProjectSetting(IssueSetting iss) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`issue_setting`\n"
                + "(`project_id`,\n"
                + "`title`,\n"
                + "`status`,\n"
                + "`description`)\n"
                + "VALUES\n"
                + "(?,?,?,?)";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, iss.getProject_id());
            pre.setString(2, iss.getTitle());
            pre.setString(3, iss.getStatus());
            pre.setString(4, iss.getDescription());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public List<IssueSetting> searchNFilterClass(String sql) {
        List<IssueSetting> list = new ArrayList<>();

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                IssueSetting iss = new IssueSetting();
                iss.setSetting_id(rs.getInt("setting_id"));
                iss.setSubject_id(rs.getInt("subject_id"));
                iss.setClass_id(rs.getInt("class_id"));
                iss.setTitle(rs.getString("title"));
                iss.setStatus(rs.getString("status"));
                iss.setCreate_at(rs.getTimestamp("create_at"));
                iss.setIsActive(rs.getInt("is_active"));
                list.add(iss);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
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

    public int updateClassSetting(IssueSetting iss) {
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

    public int getTotalClassIssueSetting(int subId, int classId) {
        String sql = "select count(*) from issue_setting where subject_id = ? and class_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, subId);
            pre.setInt(2, classId);
            ResultSet rs = pre.executeQuery(sql);
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
}
