package com.example.demo.Controllers;

import java.util.UUID;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.DTOs.ApiResponseDTO;

@RestController 
@RequestMapping("api")
public class TestController {
    
    @GetMapping("test") 
    public ApiResponseDTO getEndpoint(){
        return new ApiResponseDTO(UUID.randomUUID().toString(), "everything works correctly");
    }
}
