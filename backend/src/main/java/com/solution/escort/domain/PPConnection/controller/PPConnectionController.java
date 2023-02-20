package com.solution.escort.domain.PPConnection.controller;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.service.PPConnectionService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/ppConnection")
@Slf4j
public class PPConnectionController {
    @Autowired
    private PPConnectionService ppConnectionService;

    // 보호자 노인 등록 API => QR 등록 파트와 연동 예정
    @PostMapping
    public ResponseEntity<ResponseFormat<PPConnectionRequestDTO>> ppConnection(PPConnectionRequestDTO dto) throws Exception {
        ppConnectionService.ppConnection(dto);
        ResponseFormat<PPConnectionRequestDTO> responseFormat = new ResponseFormat<>(ResponseStatus.PUT_PROTEGE_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);
    }
}
