package com.xworkz.model.config;

import org.springframework.context.annotation.Configuration;

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
}
