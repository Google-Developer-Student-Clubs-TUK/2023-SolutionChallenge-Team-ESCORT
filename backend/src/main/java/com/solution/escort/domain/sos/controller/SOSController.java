package com.solution.escort.domain.sos.controller;

import com.solution.escort.domain.sos.dto.request.SOSRequestDTO;
import com.solution.escort.domain.sos.service.SOSServiceImpl;
import com.solution.escort.domain.sos.service.SOSservice;
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
@RequestMapping("api/v1/sos")
@Slf4j
public class SOSController {
    @Autowired
    private SOSservice sosService;

    // 배회노인 신고 api
    @PostMapping
    public ResponseEntity<ResponseFormat<SOSRequestDTO>> createSOS(SOSRequestDTO dto) throws Exception {
        sosService.createSOS(dto);
        ResponseFormat<SOSRequestDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_SOS_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);
    }

    // 배회노인 리스트 가져오기 api

}
