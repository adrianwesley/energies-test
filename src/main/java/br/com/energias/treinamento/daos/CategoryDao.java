package br.com.energias.treinamento.daos;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import br.com.energias.treinamento.models.Category;

import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryDao {

	@PersistenceContext
	private EntityManager manager;
	
	public List<Category> all()
	{
		return manager.createQuery("select c from Category c", Category.class).getResultList();
	}
	
	public void save(Category category){
		manager.persist(category);
	}
	
	public void remove(Category category)
	{
		manager.remove(category);
	}
	
	public Category findById(Integer id)
	{
		return manager.find(Category.class, id);
	}
	
	public void update(Category category)
	{
		manager.merge(category);
	}
}
