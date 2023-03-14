package com.solution.escort.domain.sos.service;

import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.sos.dto.request.SOSRequestDTO;
import com.solution.escort.domain.sos.dto.response.SOSResponseDTO;

import java.util.List;

public interface SOSservice {
    public void createSOS(Protege protege) throws Exception;
    public List<SOSResponseDTO> getSOSAll() throws Exception;
    public void deleteSOS(Integer id) throws Exception;
}
