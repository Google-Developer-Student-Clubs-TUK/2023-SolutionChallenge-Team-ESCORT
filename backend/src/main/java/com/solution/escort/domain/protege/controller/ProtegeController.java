package com.solution.escort.domain.protege.controller;

import com.solution.escort.domain.protege.dto.request.ProtegeRequestDTO;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
import com.solution.escort.domain.protege.entity.SafeZone;
import com.solution.escort.domain.protege.service.ProtegeService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/protege")
@Slf4j
public class ProtegeController {
    @Autowired
    private ProtegeService protegeService;

    // GCP Storage 발급 시 추가

    // 치매노인 회원 가입 API (이미지는 GCP 미발급으로 보류)
    @PostMapping
    public ResponseEntity<ResponseFormat<ProtegeResponseDTO>> protegeSignup(ProtegeRequestDTO dto, @RequestParam(value = "safeZones") List<String> strings) throws Exception{
        if (strings == null) {
            log.warn("세이프존이 존재하지 않습니다.");
        }

        protegeService.createProtege(dto, strings);
        ResponseFormat<ProtegeResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_EVENT_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);
    }

}
