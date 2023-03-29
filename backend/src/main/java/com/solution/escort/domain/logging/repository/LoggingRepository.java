package com.solution.escort.domain.logging.repository;

import com.solution.escort.domain.logging.entity.Logging;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.sos.entity.SOS;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LoggingRepository extends JpaRepository<Logging, Integer>{
    Logging findByProtegeId(int id);



}

