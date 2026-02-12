package com.xworkz.model.config;

import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;

@Configuration
public class FileUploadConfig {

    // Base upload directory
    public static final String UPLOAD_DIR = "D:/filefolder/";

    // Subdirectory for profile photos (optional, but keeps things organized)
    public static final String PROFILE_DIR = UPLOAD_DIR;

    // Default avatar filename (make sure this file exists in D:/filefolder if used)
    public static final String DEFAULT_AVATAR = "default-avatar.jpg";

    // Max file size (5MB)
    public static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

    // Allowed image types
    public static final String[] ALLOWED_TYPES = {"image/jpeg", "image/png", "image/gif", "image/jpg"};

    @PostConstruct
    public void ensureDirectoryExists() {
        File dir = new File(UPLOAD_DIR);

        // Create directory if it doesn't exist
        if (!dir.exists()) {
            boolean created = dir.mkdirs();
            System.out.println("Created upload directory: " + dir.getAbsolutePath() + " → " + created);
            if (!created) {
                throw new RuntimeException("❌ Failed to create: " + dir.getAbsolutePath());
            }
        } else {
            System.out.println("✅ Upload directory exists: " + dir.getAbsolutePath());
        }

        // Test write permission (more reliable than just canWrite())
        testWritePermission(dir);
    }

    private void testWritePermission(File dir) {
        File testFile = new File(dir, "test-write-permission.tmp");
        try {
            // Try to create a temp file to verify write access
            boolean created = testFile.createNewFile();
            if (created) {
                testFile.delete(); // Clean up
                System.out.println("✅ Write permission confirmed for: " + dir.getAbsolutePath());
            } else {
                throw new RuntimeException("❌ CANNOT WRITE TO: " + dir.getAbsolutePath() +
                        "\n💡 Fix: Right-click folder → Properties → Security → Edit → Add your user/SYSTEM with Full Control");
            }
        } catch (IOException e) {
            throw new RuntimeException("❌ Write permission test failed for: " + dir.getAbsolutePath() +
                    "\nError: " + e.getMessage() +
                    "\n💡 Tomcat needs Full Control on D:\\filefolder\\", e);
        }
    }
}
