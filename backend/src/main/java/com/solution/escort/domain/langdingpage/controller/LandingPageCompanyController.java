package com.solution.escort.domain.langdingpage.controller;

import com.solution.escort.domain.langdingpage.dto.request.LandingPageCompanyRequestDTO;
import com.solution.escort.domain.langdingpage.entity.LandingPageCompany;
import com.solution.escort.domain.langdingpage.service.LandingPageCompanyService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class LandingPageCompanyController {
    private final LandingPageCompanyService landingPageCompanyService;

    @PostMapping("/api/v1/landingpagecompany")

    public ResponseEntity<ResponseFormat<LandingPageCompanyRequestDTO>> createUser(@RequestBody @Valid LandingPageCompanyRequestDTO landingPageCompanyRequestDTO
    ){

        LandingPageCompany landingPageCompany = mapToLandingPageUser(landingPageCompanyRequestDTO);
        landingPageCompanyService.createLandingPageCompany(landingPageCompany);

        ResponseFormat<LandingPageCompanyRequestDTO> responseFormat =
                new ResponseFormat<>(ResponseStatus.POST_LANDING_COMPANY_SUCCESS);

        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

    private LandingPageCompany mapToLandingPageUser(LandingPageCompanyRequestDTO requestDTO){
        LandingPageCompany landingPageCompany = new LandingPageCompany();
        landingPageCompany.setManagerName(requestDTO.getManagerName());
        landingPageCompany.setEmail(requestDTO.getEmail());
        landingPageCompany.setCompanyName(requestDTO.getCompanyName());
        landingPageCompany.setMessage(requestDTO.getMessage());
        return landingPageCompany;
    }



}
