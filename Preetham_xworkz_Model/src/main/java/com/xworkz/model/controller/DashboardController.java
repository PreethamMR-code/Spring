package com.xworkz.model.controller;


import com.xworkz.model.DTO.BatchDTO;
import com.xworkz.model.DTO.BatchStudentDTO;
import com.xworkz.model.entity.BatchEntity;
import com.xworkz.model.entity.BatchStudentEntity;
import com.xworkz.model.service.BatchService;
import com.xworkz.model.service.BatchStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    BatchService batchService;

    @Autowired
    BatchStudentService batchStudentService;

    // Dashboard Home
    @GetMapping("/Home")
    public String showHomePage() {
        return "home";
    }

    // Show Add Batch Form
    @GetMapping("/addBatch")
    public String showAddBatchForm(Model model) {
        model.addAttribute("batchDTO", new BatchDTO());
        return "addBatch";
    }

    // Process Add Batch
    @PostMapping("/addBatch")
    public String addBatch(@Valid @ModelAttribute("batchDTO") BatchDTO batchDTO,
                           BindingResult bindingResult,
                           Model model) {
        if (bindingResult.hasErrors()) {
            return "addBatch";
        }

        boolean saved = batchService.createBatch(batchDTO);

        if (saved) {
            model.addAttribute("msg", "Batch created successfully!");
            return "redirect:/dashboard/viewBatches";
        } else {
            model.addAttribute("error", "Failed to create batch");
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
    public String batchDetails(@PathVariable int id, Model model) {
        BatchEntity batch = batchService.getBatchById(id);
        List<BatchStudentEntity> students = batchStudentService.getStudentsByBatchId(id);

        model.addAttribute("batch", batch);
        model.addAttribute("students", students);
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
