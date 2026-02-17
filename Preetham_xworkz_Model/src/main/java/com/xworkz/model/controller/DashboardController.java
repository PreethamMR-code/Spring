package com.xworkz.model.controller;


import com.xworkz.model.DTO.BatchDTO;
import com.xworkz.model.DTO.BatchStudentDTO;
import com.xworkz.model.entity.BatchEntity;
import com.xworkz.model.entity.BatchStudentEntity;
import com.xworkz.model.service.BatchService;
import com.xworkz.model.service.BatchStudentService;
import com.xworkz.model.service.EmailNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    BatchService batchService;

    @Autowired
    EmailNotificationService emailNotificationService;

    @Autowired
    BatchStudentService batchStudentService;

    @GetMapping("")
    public String dashboardHome() {
        return "redirect:/Home";
    }

    @GetMapping("/Home")
    public String home(Model model, HttpSession session) {

        String name  = (String) session.getAttribute("name");
        String email = (String) session.getAttribute("email");
        Object fileId = session.getAttribute("fileId");

        model.addAttribute("name",  name  != null ? name  : "User");
        model.addAttribute("email", email != null ? email : "");
        if (fileId != null) {
            model.addAttribute("fileId", fileId);
        }

        return "Home";
    }

    // Show Add Batch Form
    @GetMapping("/addBatch")
    public String showAddBatchForm(Model model) {
        model.addAttribute("activePage", "addBatch");
        model.addAttribute("batchDTO", new BatchDTO());
        return "addBatch";
    }

    // Process Add Batch (FIXED)
    @PostMapping("/addBatch")
    public String addBatch(
            @RequestParam String batchName,
            @RequestParam String instructor,
            @RequestParam String course,
            @RequestParam String startDate,
            @RequestParam String batchType,
            @RequestParam(required = false) String description,
            Model model) {

        System.out.println("=== ADD BATCH CALLED ===");
        System.out.println("Batch Name: " + batchName);
        System.out.println("Instructor: " + instructor);
        System.out.println("Course: " + course);
        System.out.println("Start Date: " + startDate);
        System.out.println("Batch Type: " + batchType);
        System.out.println("Description: " + description);

        try {
            // Create DTO manually
            BatchDTO batchDTO = new BatchDTO();
            batchDTO.setBatchName(batchName);
            batchDTO.setInstructor(instructor);
            batchDTO.setCourse(course);

            // Parse date
            LocalDate date = LocalDate.parse(startDate);
            batchDTO.setStartDate(date);

            batchDTO.setBatchType(batchType);
            batchDTO.setDescription(description);

            // Save batch
            boolean saved = batchService.createBatch(batchDTO);

            System.out.println("Batch saved: " + saved);

            if (saved) {
                model.addAttribute("msg", "Batch created successfully!");
                return "redirect:/dashboard/viewBatches";
            } else {
                model.addAttribute("error", "Failed to create batch");
                return "addBatch";
            }

        } catch (Exception e) {
            System.err.println("ERROR creating batch: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error: " + e.getMessage());
            return "addBatch";
        }
    }

    // View All Batches
    @GetMapping("/viewBatches")
    public String viewBatches(Model model) {
        List<BatchEntity> batches = batchService.getAllBatches();
        model.addAttribute("batches", batches);
        return "viewBatches";
    }

    // View Batch Details
    @GetMapping("/batchDetails/{id}")
    public String batchDetails(@PathVariable int id,
                               Model model,
                               HttpSession session) {

        // Session attributes for navbar (same as home())
        model.addAttribute("name",  session.getAttribute("name"));
        model.addAttribute("email", session.getAttribute("email"));
        model.addAttribute("fileId", session.getAttribute("fileId"));

        BatchEntity batch = batchService.getBatchById(id);
        List<BatchStudentEntity> students = batchStudentService.getStudentsByBatchId(id);

        model.addAttribute("batch", batch);
        model.addAttribute("students", students);


        java.util.Map<Integer, com.xworkz.model.entity.EmailNotificationEntity> latestResponses
                = new java.util.HashMap<>();

        List<com.xworkz.model.entity.EmailNotificationEntity> allNotifications
                = emailNotificationService.getByBatchId(id);

        // For each notification (already sorted by sentAt DESC from DAO),
        // only put the FIRST one we find for each student (= most recent)
        for (com.xworkz.model.entity.EmailNotificationEntity n : allNotifications) {
            if (!latestResponses.containsKey(n.getStudentId())) {
                latestResponses.put(n.getStudentId(), n);
            }
        }

        model.addAttribute("latestResponses", latestResponses);
        return "batchDetails";
    }


    // Show Add Student Form
    @GetMapping("/addStudent/{batchId}")
    public String showAddStudentForm(@PathVariable int batchId, Model model) {
        BatchEntity batch = batchService.getBatchById(batchId);

        BatchStudentDTO studentDTO = new BatchStudentDTO();
        studentDTO.setBatchId(batchId);

        // Generate and show next student ID
        String nextStudentId = batchStudentService.generateStudentId();

        model.addAttribute("batch", batch);
        model.addAttribute("studentDTO", studentDTO);
        model.addAttribute("nextStudentId", nextStudentId);
        return "addBatchStudent";
    }

    // Process Add Student
    @PostMapping("/addStudent")
    public String addStudent(@Valid @ModelAttribute("studentDTO") BatchStudentDTO studentDTO,
                             BindingResult bindingResult,
                             Model model) {

        if (bindingResult.hasErrors()) {
            BatchEntity batch = batchService.getBatchById(studentDTO.getBatchId());
            model.addAttribute("batch", batch);
            return "addBatchStudent";
        }

        boolean saved = batchStudentService.addStudent(studentDTO);

        if (saved) {
            return "redirect:/dashboard/batchDetails/" + studentDTO.getBatchId();
        } else {
            model.addAttribute("error", "Failed to add student");
            return "addBatchStudent";
        }
    }

    // Delete Batch
    @PostMapping("/deleteBatch/{id}")
    public String deleteBatch(@PathVariable int id) {
        batchService.deleteBatch(id);
        return "redirect:/dashboard/viewBatches";
    }

    // Delete Student
    @PostMapping("/deleteStudent/{id}/{batchId}")
    public String deleteStudent(@PathVariable int id, @PathVariable int batchId) {
        batchStudentService.deleteStudent(id);
        return "redirect:/dashboard/batchDetails/" + batchId;
    }

}
