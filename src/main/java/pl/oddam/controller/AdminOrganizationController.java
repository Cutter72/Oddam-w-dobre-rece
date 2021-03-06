package pl.oddam.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import pl.oddam.model.CurrentUser;
import pl.oddam.model.Organization;
import pl.oddam.repository.*;

import javax.validation.Valid;

@Controller
@RequestMapping("/admin/organization")
public class AdminOrganizationController {
    private final OrganizationRepository organizationRepository;
    private final OrganizationTypeRepository organizationTypeRepository;
    private final OrganizationNeedRepository organizationNeedRepository;
    private final OrganizationTargetRepository organizationTargetRepository;
    private final CityRepository cityRepository;

    public AdminOrganizationController(OrganizationRepository organizationRepository, OrganizationTypeRepository organizationTypeRepository, OrganizationNeedRepository organizationNeedRepository, OrganizationTargetRepository organizationTargetRepository, CityRepository cityRepository) {
        this.organizationRepository = organizationRepository;
        this.organizationTypeRepository = organizationTypeRepository;
        this.organizationNeedRepository = organizationNeedRepository;
        this.organizationTargetRepository = organizationTargetRepository;
        this.cityRepository = cityRepository;
    }


    @GetMapping("")
    public String adminOrganization(@AuthenticationPrincipal CurrentUser customUser, Model model) {
        model.addAttribute("user", customUser.getUser());
        model.addAttribute("newOrganization", new Organization());
        model.addAttribute("organizationList", organizationRepository.findAll());
        model.addAttribute("organizationNeedList", organizationNeedRepository.findAll());
        model.addAttribute("organizationTypeList", organizationTypeRepository.findAll());
        model.addAttribute("organizationTargetList", organizationTargetRepository.findAll());
        model.addAttribute("cityList", cityRepository.findAll());
        return "adminOrganization";
    }

    @GetMapping("/")
    public String adminOrganizationSlash() {
        return "redirect:/admin/organization";
    }

    @PostMapping("")
    public String adminSaveOrganization(@Valid Organization organization, BindingResult result, @AuthenticationPrincipal CurrentUser customUser, Model model, ModelMap modelMap) {
        if (result.hasErrors()) {
            adminOrganization(customUser, model);
            modelMap.put(BindingResult.class.getName() + ".newOrganization", result);
            return "adminOrganization";
        }
        String existingName = null;
        try {
            existingName = organizationRepository.findByName(organization.getName()).getName();
        } catch (NullPointerException e) {
            organizationRepository.save(organization);
        }
        if (existingName != null) {
            adminOrganization(customUser, model);
            model.addAttribute("newOrganization", organization);
            model.addAttribute("duplicateName", "Nazwa '" + existingName + "' jest już zajęta!");
            return "adminOrganization";
        }
        return "redirect:/admin/organization#list";
    }

    @GetMapping("/edit/{id}")
    public String adminOrganizationEdit(@AuthenticationPrincipal CurrentUser customUser, Model model, @PathVariable Long id) {
        adminOrganization(customUser, model);
        model.addAttribute("organizationToEdit", organizationRepository.findById(id).get());
        return "admin/organizationEdit";
    }

    @PostMapping("/edit/{id}")
    public String adminOrganizationEditSave(@AuthenticationPrincipal CurrentUser customUser, @Valid Organization organization, BindingResult result, Model model, @PathVariable Long id, ModelMap modelMap) {
        if (result.hasErrors()) {
            adminOrganization(customUser, model);
            modelMap.put(BindingResult.class.getName() + ".organizationToEdit", result);
            return "adminOrganization";
        }
        String existingName;
        Organization duplicateOrganization;
        try {
            duplicateOrganization = organizationRepository.findByName(organization.getName());
        } catch (NullPointerException e) {
            organizationRepository.save(organization);
            return "redirect:/admin/organization#list";
        }
        if (duplicateOrganization != null) {
            existingName = duplicateOrganization.getName();
            if (duplicateOrganization.getId() == id) {
                organizationRepository.save(organization);
                return "redirect:/admin/organization#list";
            } else {
                adminOrganizationEdit(customUser, model, id);
                model.addAttribute("duplicateName", "Nazwa '" + existingName + "' jest już zajęta!");
                return "admin/organizationEdit";
            }
        } else {
            organizationRepository.save(organization);
            return "redirect:/admin/organization#list";
        }
    }

    @GetMapping("/delete/{id}")
    public String adminOrganizationDelete(@PathVariable Long id) {
        organizationRepository.delete(organizationRepository.findById(id).get());
        return "redirect:/admin/organization#list";
    }


}
