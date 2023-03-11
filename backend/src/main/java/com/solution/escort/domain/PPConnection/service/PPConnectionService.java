package com.solution.escort.domain.PPConnection.service;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.dto.response.PtorResponseDTO;

import java.util.List;

public interface PPConnectionService {

    // 보호자 노인 등록 API 관련 서비스
    public void ppConnection(PPConnectionRequestDTO ppConnectionRequestDTO) throws Exception;

    // 보호자 -> 등록된 노인 리스트와 가져오는 API
    public List<PgeResponseDTO> getProtegeByProtectorId(Integer protectorId) throws Exception;

    // 노인 -> 등록된 보호자 리스트와 가져오는 API
    public List<PtorResponseDTO> getProtectorByProtegeId(Integer ProtegeId) throws Exception;
}
