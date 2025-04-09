/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Class;
import model.Milestone;
import org.gitlab4j.api.GitLabApiException;

/**
 *
 * @author Đàm Quang Chiến
 */
public class SyncGitLabUnderGround implements ServletContextListener {

    private final ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // This method is called when the web application starts

        // Schedule the task to run at 6 AM and 7 PM
        scheduleTask();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // This method is called when the web application is stopped
        // You can stop any running tasks here
        stopBackgroundTask();
    }

    private void scheduleTask() {
        // Calculate the initial delay to the next 4 AM or 9 PM
        Calendar now = Calendar.getInstance(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));

        // Calculate the initial delay to the next 4 AM or 9 PM
        long initialDelay4AM = calculateInitialDelay(now, 4, 0); // 4 AM
        long initialDelay9PM = calculateInitialDelay(now, 22, 0); // 10 PM

        // Choose the earlier of the two times
        long initialDelay = Math.min(initialDelay4AM, initialDelay9PM);

        long period = TimeUnit.DAYS.toMillis(1); // 24 hours (repeat daily)

        // Schedule the task
        executorService.scheduleAtFixedRate(() -> {
            // Your task logic goes here
            syncAllClassMilestone();
        }, initialDelay, period, TimeUnit.MILLISECONDS);
    }

    private void stopBackgroundTask() {
        executorService.shutdown();
    }

    private long calculateInitialDelay(Calendar now, int targetHour, int targetMinute) {
        // Set the target hour and minute
        now.set(Calendar.HOUR_OF_DAY, targetHour);
        now.set(Calendar.MINUTE, targetMinute);
        now.set(Calendar.SECOND, 0);
        now.set(Calendar.MILLISECOND, 0);

        // Calculate the initial delay until the next target time
        long currentTime = System.currentTimeMillis();
        long targetTime = now.getTimeInMillis();
        if (currentTime > targetTime) {
            // If the current time is after the target time, schedule for the next day
            return targetTime + TimeUnit.DAYS.toMillis(1) - currentTime;
        } else {
            return targetTime - currentTime;
        }
    }

    private void syncAllClassMilestone() {
        Class c = new Class();
        Milestone milestone = new Milestone();
        SyncGitLab syncGit = new SyncGitLab();
        List<Class> listClass = c.getAllClasses();
        for (Class cls : listClass) {
            if (!cls.getAccessToken().isEmpty()) {
                try {
                    List<Milestone> listMile = milestone.getListClassMilestone(cls.getClassId());
                    String subUrl = cls.getGitlabId().substring("https://gitlab.com/".length());
                    // Setup value for syncGit
                    syncGit.setGroupId(subUrl);
                    syncGit.setAccessToken(cls.getAccessToken());
                    syncGit.syncMilestones(listMile, cls.getClassId());
                } catch (GitLabApiException ex) {
                    Logger.getLogger(SyncGitLabUnderGround.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }
}
