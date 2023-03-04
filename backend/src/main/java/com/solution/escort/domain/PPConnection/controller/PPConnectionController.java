package com.solution.escort.domain.PPConnection.controller;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.service.PPConnectionService;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

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
        ResponseFormat<PPConnectionRequestDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_PPCONNECTION_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);
    }

    // 보호자 -> 등록된 모든 노인 리스트와 가져오는 API
    @GetMapping("/{protectorId}")
    public ResponseEntity<ResponseFormat<List<PgeResponseDTO>>> getPgeListByProtectorId(@PathVariable Integer protectorId) throws Exception {
//        //ppConnectionService.getProtegeByProtectorId(protectorId);
//        List<ProtegeResponseDTO> protegeAll = null;
//        protegeAll =

        List<PgeResponseDTO> pgeResponseDTO = ppConnectionService.getProtegeByProtectorId(protectorId);
        ResponseFormat<List<PgeResponseDTO>> responseFormat = new ResponseFormat<>(ResponseStatus.GET_PROTECTOR_SUCCESS, pgeResponseDTO);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
        //return ppConnectionService.getProtegeByProtectorId(protectorId);
    }

//    @GetMapping("/{protectorId}")
//    public List<Object> getPgeListByProtectorId(@PathVariable Integer protectorId) throws Exception {
//        //ppConnectionService.getProtegeByProtectorId(protectorId);
//        return ppConnectionService.getProtegeByProtectorId(protectorId);
//    }


    // 노인 -> 등록된 보호자 리스트 가져오는 API

}
