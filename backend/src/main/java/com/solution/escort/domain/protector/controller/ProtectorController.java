package com.solution.escort.domain.protector.controller;

import com.solution.escort.domain.protector.dto.request.ProtectorRequestDTO;
import com.solution.escort.domain.protector.dto.response.ProtectorResponseDTO;
import com.solution.escort.domain.protector.service.ProtectorService;
import com.solution.escort.global.GCP.GCPService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("api/v1/protector")
@Slf4j
public class ProtectorController {
    @Autowired
    private ProtectorService protectorService;

    @Autowired
    private GCPService gcpService;

    // 보호자 회원 가입 API
    @PostMapping
    public ResponseEntity<ResponseFormat<ProtectorResponseDTO>> protectorSignup(ProtectorRequestDTO dto, @RequestPart("profileImage") MultipartFile multipartFile) throws Exception{
        if(multipartFile == null){
            log.warn("파일이 존재하지 않습니다");
        }
        String url = gcpService.uploadFile(multipartFile);
        protectorService.createProtector(dto, url);
        ResponseFormat<ProtectorResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_PROTECTOR_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);

    }


    // 보호자 정보 가져오는 API
    @GetMapping("/{id}")
    public ResponseEntity<ResponseFormat<ProtectorResponseDTO>> getProtectorById(@PathVariable Integer id) throws Exception {
        ProtectorResponseDTO protector = protectorService.getProtectorById(id);
        ResponseFormat<ProtectorResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.GET_PROTECTOR_SUCCESS, protector);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }
}
