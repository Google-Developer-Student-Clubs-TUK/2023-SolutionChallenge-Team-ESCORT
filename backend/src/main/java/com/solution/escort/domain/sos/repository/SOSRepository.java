package com.solution.escort.domain.sos.repository;

import com.solution.escort.domain.sos.entity.SOS;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SOSRepository extends JpaRepository<SOS, Integer> {
    SOS findByProtegeId(int id);

    boolean existsByProtegeId(int id);

}
