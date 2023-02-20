package com.solution.escort.domain.protector.controller;

import com.solution.escort.domain.protector.dto.request.ProtectorRequestDTO;
import com.solution.escort.domain.protector.dto.response.ProtectorResponseDTO;
import com.solution.escort.domain.protector.service.ProtectorService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/protector")
@Slf4j
public class ProtectorController {
    @Autowired
    private ProtectorService protectorService;

    // 보호자 회원 가입 API
    @PostMapping
    public ResponseEntity<ResponseFormat<ProtectorResponseDTO>> protectorSignup(ProtectorRequestDTO dto) throws Exception{
        protectorService.createProtector(dto);
        ResponseFormat<ProtectorResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_PROTECTOR_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);

    }

    // 보호자 아이디에 연결되어있는 노인들의 정보를 가져오는 API


    //
}
