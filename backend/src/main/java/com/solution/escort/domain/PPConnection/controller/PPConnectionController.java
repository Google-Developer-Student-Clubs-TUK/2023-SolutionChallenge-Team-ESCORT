package com.solution.escort.domain.PPConnection.controller;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.dto.response.PtorResponseDTO;
import com.solution.escort.domain.PPConnection.service.PPConnectionService;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protector.repository.ProtectorRepository;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.protege.repository.ProtegeRepository;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/v1/ppConnection")
@Slf4j
public class PPConnectionController {
    @Autowired
    private PPConnectionService ppConnectionService;

    @Autowired
    private ProtegeRepository protegeRepository;

    @Autowired
    private ProtectorRepository protectorRepository;

    // 보호자 노인 등록 API
    @PostMapping
    public ResponseEntity<ResponseFormat<PPConnectionRequestDTO>> ppConnection(PPConnectionRequestDTO dto) throws Exception {
        int protegeId = protegeRepository.findByFbId(dto.getProtegeUId()).getId();
        int protectorId = protectorRepository.findByFbId(dto.getProtectorUId()).getId();

        Protege protege = protegeRepository.findById(protegeId);
        Protector protector = protectorRepository.findById(protectorId);

        ppConnectionService.ppConnection(protege, protector);
        ResponseFormat<PPConnectionRequestDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_PPCONNECTION_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);
    }

    // 보호자 -> 등록된 모든 노인 리스트와 가져오는 API
    @GetMapping("/protector/{uId}")
    public ResponseEntity<ResponseFormat<List<PgeResponseDTO>>> getPgeListByProtectorId(@PathVariable String uId) throws Exception {
        int protectorId = protectorRepository.findByFbId(uId).getId();

        List<PgeResponseDTO> pgeResponseDTO = ppConnectionService.getProtegeByProtectorId(protectorId);
        ResponseFormat<List<PgeResponseDTO>> responseFormat = new ResponseFormat<>(ResponseStatus.GET_PROTEGE_SUCCESS, pgeResponseDTO);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

    // 노인 -> 등록된 보호자 리스트 가져오는 API
    @GetMapping("/protege/{uId}")
    public ResponseEntity<ResponseFormat<List<PtorResponseDTO>>> getPtorResponseId(@PathVariable String uId) throws Exception {
        int protegeId = protegeRepository.findByFbId(uId).getId();


        List<PtorResponseDTO> ptorResponseDTO = ppConnectionService.getProtectorByProtegeId(protegeId);
        ResponseFormat<List<PtorResponseDTO>> responseFormat = new ResponseFormat<>(ResponseStatus.GET_PROTECTOR_SUCCESS, ptorResponseDTO);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

}
