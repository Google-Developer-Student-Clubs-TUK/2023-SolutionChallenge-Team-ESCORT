package com.solution.escort.domain.langdingpage.service;

import com.solution.escort.domain.langdingpage.entity.LandingPageUser;
import com.solution.escort.domain.langdingpage.repository.LandingPageUserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
@Slf4j
public class LandingPageUserService {
    private  final LandingPageUserRepository landingPageUserRepository;
    public void createLandingPageUser(LandingPageUser landingPageUser){

        landingPageUserRepository.save(landingPageUser);

    }
}
