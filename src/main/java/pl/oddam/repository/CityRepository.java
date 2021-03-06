package pl.oddam.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.oddam.model.City;

@Repository
public interface CityRepository extends JpaRepository<City, Long> {

}
