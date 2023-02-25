package com.solution.escort.domain.sos.service;

import com.solution.escort.domain.sos.dto.request.SOSRequestDTO;
import com.solution.escort.domain.sos.dto.response.SOSResponseDTO;

import java.util.List;

public interface SOSservice {
    public void createSOS(SOSRequestDTO sosRequestDTO) throws Exception;
    public List<SOSResponseDTO> getSOSAll() throws Exception;
    public void deleteSOS(Integer id) throws Exception;
}
