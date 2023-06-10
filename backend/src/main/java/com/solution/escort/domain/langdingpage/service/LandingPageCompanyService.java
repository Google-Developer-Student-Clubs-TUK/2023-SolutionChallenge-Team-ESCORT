package com.solution.escort.domain.langdingpage.service;

import com.solution.escort.domain.langdingpage.entity.LandingPageCompany;
import com.solution.escort.domain.langdingpage.repository.LandingPageCompanyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
@Slf4j
public class LandingPageCompanyService {
    private  final LandingPageCompanyRepository landingPageCompanyRepository;

    public void createLandingPageCompany(LandingPageCompany landingPageCompany){

        landingPageCompanyRepository.save(landingPageCompany);

    }

}
