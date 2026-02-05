package com.xworkz.model.config;

import org.springframework.context.annotation.Configuration;

@Configuration
public class FileUploadConfig {

    // Base upload directory
    public static final String UPLOAD_DIR = "D:/XWorkz/uploads/";

    // Profile photos subdirectory
    public static final String PROFILE_DIR = UPLOAD_DIR + "profiles/";

    // Default avatar filename
    public static final String DEFAULT_AVATAR = "default-avatar.png";

    // Max file size (5MB)
    public static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

    // Allowed image types
    public static final String[] ALLOWED_TYPES = {"image/jpeg", "image/png", "image/gif", "image/jpg"};
}
