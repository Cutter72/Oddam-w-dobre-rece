package pl.oddam.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.oddam.model.DomainSettings;
import pl.oddam.model.TokenParams;

import javax.mail.MessagingException;

@Service
@Transactional
public class PasswordResetService {
    private final EmailService emailService;
    private final DomainSettings domainSettings;
    private final TokenService tokenService;

    public PasswordResetService(EmailService emailService, DomainSettings domainSettings, TokenService tokenService) {
        this.emailService = emailService;
        this.domainSettings = domainSettings;
        this.tokenService = tokenService;
    }

    public void sendToken(String email) throws MessagingException {
        TokenParams newToken = tokenService.createNewToken(email);
        String text = "Kliknij w link aby zresetowac swoje hasło: <a href=\""+domainSettings.getAddress()+"password/reset/" + newToken.getToken() + "\">link</a><br/>UWAGA! Ważność linku to 30 minut!";
        emailService.sendMimeMessage(domainSettings.getMail(), email, "Reset hasła w portalu Oddam w dobre ręce", text);
    }
}
