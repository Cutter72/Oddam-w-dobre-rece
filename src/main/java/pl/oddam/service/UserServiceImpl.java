package pl.oddam.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pl.oddam.model.Role;
import pl.oddam.model.User;
import pl.oddam.repository.RoleRepository;
import pl.oddam.repository.UserRepository;

import java.util.Arrays;
import java.util.HashSet;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    public UserServiceImpl(UserRepository userRepository,
                           RoleRepository roleRepository, BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public void saveUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        Role userRole = roleRepository.findByName("ROLE_USER");
        user.setRoles(new HashSet<Role>(Arrays.asList(userRole)));
        userRepository.save(user);
    }

    @Override
    public void saveAdmin(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        Role userRole = roleRepository.findByName("ROLE_ADMIN");
        user.setRoles(new HashSet<Role>(Arrays.asList(userRole)));
        userRepository.save(user);
    }

    @Override
    public void editAdmin(User user) {

        Role userRole = roleRepository.findByName("ROLE_ADMIN");
        user.setRoles(new HashSet<Role>(Arrays.asList(userRole)));
        userRepository.save(user);
    }

    @Override
    public void editUser(User user) {

        Role userRole = roleRepository.findByName("ROLE_USER");
        user.setRoles(new HashSet<Role>(Arrays.asList(userRole)));
        userRepository.save(user);
    }

    @Override
    public void activateNewUser(String email) {
        User user = userRepository.findByEmail(email);
        user.setEnabled(true);
        Role role = roleRepository.findByName("ROLE_USER");
        user.setRoles(new HashSet<>(Arrays.asList(role)));
        userRepository.save(user);
    }
    @Override
    public void banUser(Long id) {
        User user = userRepository.findById(id).get();
        user.setEnabled(false);
        Role role = roleRepository.findByName("ROLE_USER_DEACTIVATED");
        user.setRoles(new HashSet<>(Arrays.asList(role)));
        userRepository.save(user);
    }
    @Override
    public void unBanUser(Long id) {
        User user = userRepository.findById(id).get();
        user.setEnabled(true);
        Role role = roleRepository.findByName("ROLE_USER");
        user.setRoles(new HashSet<>(Arrays.asList(role)));
        userRepository.save(user);
    }
}
