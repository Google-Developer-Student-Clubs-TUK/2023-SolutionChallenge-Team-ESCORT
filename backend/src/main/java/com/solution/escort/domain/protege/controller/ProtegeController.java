package com.solution.escort.domain.protege.controller;

import com.solution.escort.domain.protege.dto.request.ProtegeClothRequestDTO;
import com.solution.escort.domain.protege.dto.request.ProtegeRequestDTO;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
import com.solution.escort.domain.protege.repository.ProtegeRepository;
import com.solution.escort.domain.protege.service.ProtegeService;
import com.solution.escort.global.GCP.GCPService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("api/v1/protege")
@Slf4j
public class ProtegeController {
    @Autowired
    private ProtegeService protegeService;

    @Autowired
    private GCPService gcpService;

    @Autowired
    private ProtegeRepository protegeRepository;



    // 치매노인 회원 가입 API
    @PostMapping
    public ResponseEntity<ResponseFormat<ProtegeResponseDTO>> protegeSignup(ProtegeRequestDTO dto, @RequestParam(value = "safeZones") List<String> strings, @RequestPart("profileImage") MultipartFile multipartFile) throws Exception {
        if (strings == null) {
            log.warn("세이프존이 존재하지 않습니다.");
        }
        if(multipartFile == null){
            log.warn("파일이 존재하지 않습니다");
        }
        String url = gcpService.uploadFile(multipartFile);
        protegeService.createProtege(dto, strings, url);

        ResponseFormat<ProtegeResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_PROTEGE_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);
    }


    // 노인 한명의 정보 가져오기 API
    @GetMapping("/{uId}")
    public ResponseEntity<ResponseFormat<ProtegeResponseDTO>> getProtegeById(@PathVariable String uId) throws Exception{
        int id = protegeRepository.findByFbId(uId).getId();
        ProtegeResponseDTO protege = protegeService.getProtegeById(id);
        ResponseFormat<ProtegeResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.GET_PROTEGE_SUCCESS, protege);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

    // 노인 신고 시 노인의 옷차림 추가하는 API
    @PutMapping("/{uId}")
    public ResponseEntity<ResponseFormat<ProtegeClothRequestDTO>> protegeCloth(ProtegeClothRequestDTO dto, @PathVariable String uId) throws Exception {
        int id = protegeRepository.findByFbId(uId).getId();
        protegeService.protegeCloth(dto, id);
        ResponseFormat<ProtegeClothRequestDTO> responseFormat = new ResponseFormat<>(ResponseStatus.PUT_PROTEGE_CLOTHING_SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

}
