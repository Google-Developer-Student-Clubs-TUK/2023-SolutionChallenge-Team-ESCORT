package com.solution.escort.domain.PPConnection.service;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import org.springframework.stereotype.Service;

public interface PPConnectionService {

    // 보호자 노인 등록 API 관련 서비스
    public void ppConnection(PPConnectionRequestDTO ppConnectionRequestDTO) throws Exception;
}
