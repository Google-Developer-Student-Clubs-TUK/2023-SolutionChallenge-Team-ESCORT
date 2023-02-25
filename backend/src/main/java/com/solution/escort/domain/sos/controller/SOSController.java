package com.solution.escort.domain.sos.controller;

import com.solution.escort.domain.sos.dto.request.SOSRequestDTO;
import com.solution.escort.domain.sos.dto.response.SOSResponseDTO;
import com.solution.escort.domain.sos.service.SOSServiceImpl;
import com.solution.escort.domain.sos.service.SOSservice;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    @GetMapping
    public ResponseEntity<ResponseFormat<List<SOSResponseDTO>>> getSOSAll() throws Exception {
        List<SOSResponseDTO> sosAll = null;
        sosAll = sosService.getSOSAll();
        ResponseFormat<List<SOSResponseDTO>> responseFormat = new ResponseFormat<>(ResponseStatus.GET_SOS_SUCCESS, sosAll);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

    // 배회노인 신고 취소 api
    @DeleteMapping("/{id}")
    public ResponseEntity<ResponseFormat<SOSResponseDTO>> deleteSOSByID(@PathVariable Integer id) throws Exception {
        sosService.deleteSOS(id);
        ResponseFormat<SOSResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.DELETE_SOS_SUCCESS);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

}
