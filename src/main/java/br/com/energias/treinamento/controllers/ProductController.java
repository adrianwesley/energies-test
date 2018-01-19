package br.com.energias.treinamento.controllers;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.energias.treinamento.daos.CategoryDao;
import br.com.energias.treinamento.daos.ProductDao;
import br.com.energias.treinamento.models.Product;

@Controller
@RequestMapping("/product")
@Transactional
public class ProductController
{

   @Autowired
   private ProductDao productDao;
   
   @Autowired
   private CategoryDao categoryDao;

   @GetMapping("/form")
   public ModelAndView form(Product product)
   {
      ModelAndView modelAndView = new ModelAndView("product/form-add");
      modelAndView.addObject("categoryList", categoryDao.all());
      return modelAndView;
   }

   @PostMapping
   public ModelAndView save(@Valid Product product, BindingResult bindingResult)
   {
      if (bindingResult.hasErrors())
      {
         return form(product);
      }
      productDao.save(product);
      return new ModelAndView("redirect:/product");
   }

   @GetMapping("/{id}")
   public ModelAndView load(@PathVariable("id") Integer id)
   {
      ModelAndView modelAndView = new ModelAndView("product/form-update");
      modelAndView.addObject("product", productDao.findById(id));
      modelAndView.addObject("categoryList", categoryDao.all());
      return modelAndView;
   }

   @GetMapping
   public ModelAndView list(@RequestParam(defaultValue = "0", required = false) int page)
   {
      ModelAndView modelAndView = new ModelAndView("product/list");
      modelAndView.addObject("paginatedList", productDao.paginated(page, 10));
      return modelAndView;
   }

   @GetMapping("/remove/{id}")
   public String remove(@PathVariable("id") Integer id)
   {
      Product product = productDao.findById(id);
      productDao.remove(product);
      return "redirect:/product";
   }

   @PostMapping("/{id}")
   public ModelAndView update(@PathVariable("id") Integer id, @Valid Product product, BindingResult bindingResult)
   {
      product.setId(id);
      if (bindingResult.hasErrors())
      {
         return new ModelAndView("product/form-update");
      }
      productDao.update(product);
      return new ModelAndView("redirect:/product");
   }
}
