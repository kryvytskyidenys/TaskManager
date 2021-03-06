package com.krivitskiy.controllers;

import com.krivitskiy.model.Task;


import com.krivitskiy.model.User;
import com.krivitskiy.service.SecurityService;
import com.krivitskiy.service.TaskService;

import com.krivitskiy.service.UserService;

import com.krivitskiy.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Date;

@Controller
@RequestMapping("/task-manager")
public class TaskController {

    private UserService userService;

    private SecurityService securityService;

    private UserValidator userValidator;

    private final TaskService taskService;

    @Autowired
    public TaskController(UserService userService, SecurityService securityService, UserValidator userValidator, TaskService taskService) {
        this.userService = userService;
        this.securityService = securityService;
        this.userValidator = userValidator;
        this.taskService = taskService;
    }

    @GetMapping("/tasks")
    public String home(HttpServletRequest request) {
        String username = securityService.findLoggedInUsername();
        User user = userService.findByName(username);
        request.setAttribute("username", user.getUsername());
        request.setAttribute("tasks", taskService.findAllByUserId(user.getId()));
        return "index";
    }

    @GetMapping("/new-task")
    public String newTask(HttpServletRequest request) {
        String username = securityService.findLoggedInUsername();
        request.setAttribute("username", username);
        return "manageTask";
    }

    @PostMapping("/save-task")
    public String saveTask(@Valid @ModelAttribute("taskForm") Task task, BindingResult bindingResult, HttpServletRequest request) {
        if(bindingResult.hasErrors()){
            String username = securityService.findLoggedInUsername();
            request.setAttribute("username", username);
            request.setAttribute("task", task);
            return "manageTask";
        }

        String username = securityService.findLoggedInUsername();
        User user = userService.findByName(username);
        task.setUser(user);
        task.setDateCreated(new Date());
        taskService.add(task);
        return "redirect:/task-manager/tasks";
    }

    @GetMapping("/save-task")
    public String saveTaskLangSwap(HttpServletRequest request){
        return "manageTask";
    }

    @GetMapping("/edit-task")
    public String editTask(@RequestParam int id, HttpServletRequest request) {
        String username = securityService.findLoggedInUsername();
        request.setAttribute("username", username);
        request.setAttribute("task", taskService.find(id));
        return "manageTask";
    }

    @GetMapping("/delete-task")
    public String deleteTask(@RequestParam int id, HttpServletRequest request) {
        taskService.delete(id);
        return "redirect:/task-manager/tasks";
    }

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @PostMapping(value = "/registration")
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autoLogin(userForm.getUsername(), userForm.getConfirmPassword());

        return "redirect:/task-manager/tasks";
    }

    @GetMapping({"/", "/login"})
    public String login(Model model, String error, String logout) {

        if (error != null) {
            model.addAttribute("error", "Username or password are incorrect.");
        }
        if (logout != null) {
            model.addAttribute("message", "Logged out successfully!");
        }

        return "login";
    }

    @GetMapping("/logout")
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/task-manager/login?logout";
    }
}
