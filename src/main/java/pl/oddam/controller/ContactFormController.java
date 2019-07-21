package pl.oddam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pl.oddam.service.EmailService;
import pl.oddam.service.ReCaptchaService;

import java.io.IOException;

@Controller
@RequestMapping("/contact")
public class ContactFormController {
    private final EmailService emailService;
    private final ReCaptchaService reCaptchaService;

    public ContactFormController(EmailService emailService, ReCaptchaService reCaptchaService) {
        this.emailService = emailService;
        this.reCaptchaService = reCaptchaService;
    }

    @PostMapping("/send")
    public String send(@RequestParam("g-recaptcha-response") String recaptchaResponse, @RequestParam String name, @RequestParam String email, @RequestParam String text, RedirectAttributes ra) throws IOException {
        if (reCaptchaService.processResponse(recaptchaResponse)) {
            emailService.sendSimpleMessage("oddam.w.dobre.rece@interia.pl", "oddam.w.dobre.rece@interia.pl", "Kontakt poprzez formularz od " + name, name + " " + email + " napisał/a\n\n\"" + text + "\"");
            emailService.sendSimpleMessage("oddam.w.dobre.rece@interia.pl", email, "Dziękujęmy " + name + " za kontakt.", "Twoja widomosć jaką otrzymaliśmy to: \n\n\"" + text + "\"\n\n Odpowiemy tak szybko jak to możliwe.\nZ poważaniem,\nzespół Oddam w dobre ręce :)");
            return "sendSuccess";
        } else {
            ra.addFlashAttribute("captchaNotChecked","Proszę zaznaczyć że nie jesteś robotem!");
            ra.addFlashAttribute("name",name);
            ra.addFlashAttribute("email",email);
            ra.addFlashAttribute("text",text);
            return "redirect:/#Contact";
        }
    }
}
