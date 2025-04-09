/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Project;

/**
 *
 * @author TRAN DUNG
 */
public class ProjectDAO extends DBConnect {

    public List<Project> getListProject(String class_id) {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391-spp`.project where class_id=?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, class_id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Project(
                        rs.getInt("project_id"),
                        rs.getInt("class_id"),
                        rs.getString("project_code"),
                        rs.getString("project_en_name"),
                        rs.getString("project_vi_name"),
                        rs.getString("project_descript"),
                        rs.getString("group_name"),
                        rs.getInt("mentor_id"),
                        rs.getInt("co_mentor_id"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ResultSet getProjectByProjectID(String project_id) {
        ResultSet rs = null;
        String sql = "select * from `swp391-spp`.project where project_id =" + project_id;
        rs = getData(sql);
        return rs;
    }

    public ResultSet getMilestones(String project_id) {
        ResultSet rs = null;
        String sql = "SELECT * FROM `swp391-spp`.milestone where project_id =" + project_id;
        rs = getData(sql);
        return rs;
    }

    public ResultSet getStudentData(String student_id) {
        ResultSet rs = null;
        String sql = "select  * from (SELECT project_id, student_id,class_id,full_name, email, class_student.is_active,is_leader FROM `swp391-spp`.class_student\n"
                + " join user u\n"
                + " on user_id = student_id\n"
                + " where student_id = " + student_id + " ) s join project\n"
                + " on s.project_id = project.project_id";
        rs = getData(sql);
        return rs;
    }

    public ResultSet getWaitingList(String class_id) {
        ResultSet rs = null;
        String sql = "SELECT class_id, student_id, full_name, email, class_student.is_active,is_leader,mobile FROM `swp391-spp`.class_student\n"
                + "join user\n"
                + "on user_id = student_id\n"
                + " where project_id = 0 and class_id=" + class_id;
        rs = getData(sql);
        return rs;
    }

    public ResultSet checkNullWaitingList(String class_id) {
        ResultSet rs = null;
        String sql = "SELECT * FROM `swp391-spp`.class_student \n"
                + " where project_id = 0 and class_id= " + class_id;
        rs = getData(sql);
        return rs;
    }

    public ResultSet getProjectMember(String project_id) {
        ResultSet rs = null;
        String sql = "SELECT project_id, student_id,class_id, full_name, email, class_student.is_active ,is_leader,mobile FROM `swp391-spp`.class_student\n"
                + " join user\n"
                + " on user_id = student_id\n"
                + " where project_id =" + project_id;
        rs = getData(sql);
        return rs;
    }

    public ResultSet getAllClassProjectMentor(int userID) {
        ResultSet rs = null;
        String sql = "select * from class where class_id in (select class_id from project where mentor_id = " + userID + ")";
        rs = getData(sql);
        System.out.println(rs);
        return rs;
    }

    public ResultSet getAllClassOfSubject(int userID) {
        ResultSet rs = null;
        String sql = "select * from class where subject_id in (select subject_id from subject where manager_id=" + userID + ")";
        rs = getData(sql);
        System.out.println(rs);
        return rs;
    }

    public ResultSet getAllClassClassManager(int userID) {
        ResultSet rs = null;
        String sql = "SELECT class_id,class_code FROM `swp391-spp`.class where class_id in (select class_id from class \n"
                + "where manager_id = " + userID + ") ";
        rs = getData(sql);
        return rs;
    }

    public ResultSet getAllClassAdmin() {
        ResultSet rs = null;
        String sql = "SELECT class_id,class_code FROM `swp391-spp`.class where manager_id IS NOT NULL ";
        rs = getData(sql);
        return rs;
    }

    public int getcurStatusOfProject(String project_id) {
        int curStatus = 0;
        try {
            ResultSet rs = null;
            String sql = "SELECT status FROM `swp391-spp`.project where project_id =  " + project_id;
            rs = getData(sql);
            while (rs.next()) {
                curStatus = rs.getInt(1);
            }
            return curStatus;
        } catch (SQLException ex) {
            Logger.getLogger(ProjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return curStatus;
    }

    public String getMentorNamebyProjectID(String project_id) throws SQLException {
        String name = null;
        ResultSet rs = null;
        String sql = "select full_name from user where user_id=( SELECT mentor_id FROM `swp391-spp`.project where project_id=" + project_id + ")";
        rs = getData(sql);
        while (rs.next()) {
            name = rs.getString(1);
        }
        return name;
    }

    public String getClassIdByProjectID(String project_id) throws SQLException {
        String class_id = null;
        ResultSet rs = null;
        String sql = "select class_id from project where project_id=" + project_id;
        rs = getData(sql);
        while (rs.next()) {
            class_id = rs.getString(1);
        }
        return class_id;
    }

    public String getCo_MentorNamebyProjectID(String project_id) throws SQLException {
        String name = null;
        ResultSet rs = null;
        String sql = "select full_name from user where user_id=( SELECT co_mentor_id FROM `swp391-spp`.project where project_id=" + project_id + ")";
        rs = getData(sql);
        while (rs.next()) {
            name = rs.getString(1);
        }
        return name;
    }

    public int addProject(Project pro) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`project`\n"
                + " (`project_code`,`project_en_name`,`project_vi_name`,`project_descript`,`status`,`class_id`,`group_name`,`mentor_id`,`co_mentor_id`) "
                + " VALUES (?,?,?,?,?,?,?,?,?);";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, pro.getProject_code());
            pre.setString(2, pro.getProject_en_name());
            pre.setString(3, pro.getProject_vi_name());
            pre.setString(4, pro.getProject_descript());
            pre.setInt(5, pro.getStatus());
            pre.setInt(6, pro.getClass_id());
            pre.setString(7, pro.getGroup_name());
            pre.setInt(8, pro.getMentor_id());
            pre.setInt(9, pro.getCo_mentor_id());

            n = pre.executeUpdate();

            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int importProExcel(Project pro) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`project`\n"
                + " (`project_code`,`project_en_name`,`project_vi_name`,`project_descript`,`status`,`class_id`,`group_name`,`mentor_id`,`co_mentor_id`) "
                + " VALUES (?,?,?,?,?,?,?,?,?);";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, pro.getProject_code());
            pre.setString(2, pro.getProject_en_name());
            pre.setString(3, pro.getProject_vi_name());
            pre.setString(4, pro.getProject_descript());
            pre.setInt(5, 0);
            pre.setInt(6, pro.getClass_id());
            pre.setString(7, pro.getGroup_name());
            pre.setInt(8, 51);
            pre.setInt(9, 51);

            n = pre.executeUpdate();

            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int UpdateProject(Project pro) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`project` SET `project_code` = ?, "
                + "`project_en_name` = ?, `project_vi_name` =?, `project_descript` = ?, "
                + "`status` = ?, `class_id` = ?, `group_name` = ?, `mentor_id` = ?, "
                + "`co_mentor_id` = ?, `access_token` = ?, `url` = ?  WHERE `project_id` = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, pro.getProject_code());
            pre.setString(2, pro.getProject_en_name());
            pre.setString(3, pro.getProject_vi_name());
            pre.setString(4, pro.getProject_descript());
            pre.setInt(5, pro.getStatus());
            pre.setInt(6, pro.getClass_id());
            pre.setString(7, pro.getGroup_name());
            pre.setInt(8, pro.getMentor_id());
            pre.setInt(9, pro.getCo_mentor_id());
            pre.setInt(12, pro.getProject_id());
            pre.setString(10, pro.getAccess_token());
            pre.setString(11, pro.getUrl());

            n = pre.executeUpdate();

            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    // set leader function
    public int setLeader(String project_id, String student_id, String class_id) {
        int n = 0;
        String curLeader_id = null;
        String getCurLeader = "select student_id from class_student\n"
                + "where class_id = " + class_id + " "
                + "and project_id = " + project_id + " "
                + "and is_leader = 1";
        String updateCurLeader = "UPDATE `swp391-spp`.`class_student`\n"
                + " SET\n"
                + " `is_leader` = 0\n"
                + " WHERE `student_id` = ?";
        try {
            PreparedStatement pre1 = connection.prepareStatement(updateCurLeader);

            ResultSet rs = null;
            rs = getData(getCurLeader);
            while (rs.next()) {
                curLeader_id = rs.getString(1);
            }
            pre1.setString(1, curLeader_id);
            n = pre1.executeUpdate();
            updateNewLeader(student_id);
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int updateNewLeader(String student_id) {
        int n = 0;
        String updateNewLeader = "UPDATE `swp391-spp`.`class_student`\n"
                + " SET\n"
                + " `is_leader` = 1\n"
                + " WHERE `student_id` =?";
        try {
            PreparedStatement pre2 = connection.prepareStatement(updateNewLeader);
            pre2.setString(1, student_id);
            n = pre2.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int startClass(String class_id) {
        int n = 0;
        String startClass = "UPDATE `swp391-spp`.`class`SET `status` = 1 WHERE `class_id` = ?";
        try {
            PreparedStatement pre2 = connection.prepareStatement(startClass);
            pre2.setString(1, class_id);
            n = pre2.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int activeAllProject(String class_id) {
        int n = 0;
        int m = startClass(class_id);
        String activeAllProject = "UPDATE `swp391-spp`.`project`\n"
                + " SET\n"
                + " `status` = 1\n"
                + " WHERE `class_id` = ?";
        try {
            PreparedStatement pre2 = connection.prepareStatement(activeAllProject);
            pre2.setString(1, class_id);
            n = pre2.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int moveMemberProject(String student_id, String project_id) {
        int n = 0;
        String moveMemberProject = "UPDATE `swp391-spp`.`class_student`\n"
                + " SET\n"
                + " `project_id` = ?, \n"
                + " `is_leader` = 0\n"
                + " WHERE `student_id` = ?";
        try {
            PreparedStatement pre2 = connection.prepareStatement(moveMemberProject);
            pre2.setString(1, project_id);
            pre2.setString(2, student_id);

            n = pre2.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int setStatus(String student_id, String status) {
        int n = 0;
        String setStatus = "UPDATE `swp391-spp`.`class_student`\n"
                + " SET\n"
                + " `is_active` = ?\n"
                + " WHERE `student_id` =?";
        try {
            PreparedStatement pre2 = connection.prepareStatement(setStatus);
            pre2.setString(1, status);
            pre2.setString(2, student_id);
            n = pre2.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int addMemberToProject(String student_id, String project_id) {
        int n = 0;
        String addMemberToProject = "UPDATE `swp391-spp`.`class_student` SET \n"
                + "`project_id` = ?\n"
                + "WHERE student_id = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(addMemberToProject);
            pre.setString(1, project_id);
            pre.setString(2, student_id);
            n = pre.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    // end of set leader function
    public int removeMember(String project_id, String student_id, String class_id) {
        int n = 0;
        String removeLeader = "UPDATE `swp391-spp`.`class_student` SET \n"
                + "`project_id` = 0, is_leader=0 \n"
                + "WHERE student_id =?";
        try {
            PreparedStatement pre = connection.prepareStatement(removeLeader);
            pre.setString(1, student_id);
            n = pre.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateStudentBeforeDeleteProject(String project_id) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`class_student` SET \n"
                + "`project_id` = 0, is_leader=0 \n"
                + "WHERE project_id =?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setString(1, project_id);

            n = pre.executeUpdate();

            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int deleteProjectByProject_id(String project_id) {
        int n = 0;
        String sql = "DELETE FROM `swp391-spp`.`project` WHERE project_id = ? and status=0";
        try {
            updateStudentBeforeDeleteProject(project_id);
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, project_id);
            n = pre.executeUpdate();
            return n;
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public ResultSet getAllProject() {
        ResultSet rs = null;
        String sql = "select * from `swp391-spp`.project";
        rs = getData(sql);

        return rs;
    }

    public ResultSet getProjectAdmin() {
        ResultSet rs = null;
        String sql = "select * from `swp391-spp`.project ";
        rs = getData(sql);
        return rs;
    }

    public ResultSet getProjectByClassID(String class_id) {
        ResultSet rs = null;
        String sql = "select * from `swp391-spp`.project where class_id =" + class_id;
        rs = getData(sql);

        return rs;
    }

    public ResultSet getClassCode(String class_id) {
        ResultSet rs = null;
        String sql = "SELECT class_id, class_code FROM `swp391-spp`.class where class_id=" + class_id;
        rs = getData(sql);
        return rs;
    }

    public String getClassCodeString(String class_id) throws SQLException {
        ResultSet rs = null;
        String class_code = "";
        String sql = "SELECT class_code FROM `swp391-spp`.class where class_id=" + class_id;
        rs = getData(sql);
        while (rs.next()) {
            class_code = rs.getString("class_code");
        }
        return class_code;
    }

    public ResultSet getAllMentorName() {
        ResultSet rs = null;
        String sql = "select user_id, full_name from user where role_id = 18";
        rs = getData(sql);
        return rs;
    }

    //get student who is not leader and not in any project
    public ResultSet getAllStudentByClass(String class_id) {
        ResultSet rs = null;
        String sql = " select student_id, full_name from class_student\n"
                + " join user\n"
                + " on student_id = user_id\n"
                + " where class_id = " + class_id + " and is_leader = 0 and project_id = 0";
        rs = getData(sql);
        return rs;
    }

    public String getMentorNamebyID(int user_id) throws SQLException {
        ResultSet rs = null;
        String mentorName = null;
        String sql = "SELECT full_name FROM user where user_id =" + user_id;
        rs = getData(sql);
        while (rs.next()) {
            mentorName = rs.getString(1);
        }
        return mentorName;
    }

    public String getClassNamebyID(int class_id) throws SQLException {
        ResultSet rs = null;
        String className = null;
        String sql = "SELECT class_code FROM `swp391-spp`.class where class_id=" + class_id;
        rs = getData(sql);
        while (rs.next()) {
            className = rs.getString(1);
        }
        return className;
    }

    public String getLeaderNamebyProjectID(int project_id) throws SQLException {
        ResultSet rs = null;
        String leaderName = null;
        String sql = "select full_name from user where user_id = (select student_id from `swp391-spp`.class_student where project_id = " + project_id + " and is_leader=1)";
        rs = getData(sql);
        while (rs.next()) {
            leaderName = rs.getString(1);
        }
        return leaderName;
    }

    public boolean checkProjectExisted(int projectId) {
        String sql = "SELECT count(*) FROM `swp391-spp`.project where project_id =?  ;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, projectId);
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

    public static void main(String[] args) throws SQLException {
        ProjectDAO dao = new ProjectDAO();
//        List<Project> n = dao.getListProject("1");
//        System.out.println(n);

        System.out.println(dao.getClassCodeString("1"));
    }
}
