package com.sos.recipe.model.sevice;


import com.sos.common.model.vo.PageInfo;
import com.sos.recipe.model.dao.RecipeDao;
import com.sos.recipe.model.vo.OrderProduct;
import com.sos.recipe.model.vo.Recipe;
import com.sos.recipe.model.vo.RecipeInsert;

import static com.sos.common.template.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;;

public class RecipeService {
	
	//1.dao 객체 생성 
	private RecipeDao rDao = new RecipeDao();

	public int selectListCount() {
		Connection conn = getConnection();
		int listCount= rDao.selectListCount(conn);
		close(conn);
		return listCount;
	}

	public List<Recipe> selectRecipeList(PageInfo pi) {
		Connection conn = getConnection();
		List<Recipe> list= rDao.selectRecipeList(conn, pi);
		close(conn);
		return list;
	}

	public List<Recipe> selectCategoryList(PageInfo pi, int categoryNo) {
		Connection conn = getConnection();
		List<Recipe> categoryList= rDao.selectCategoryList(conn, pi, categoryNo);
		close(conn);
		return categoryList;
	}

	public List<Recipe> selectSearchList(PageInfo pi, String search) {
		Connection conn = getConnection();
		List<Recipe> searchList= rDao.selectSearchList(pi, conn, search);
		close(conn);
		return searchList;
	}

	public int selectCategoryListCount(int categoryNo) {
		Connection conn = getConnection();
		int categoryListCount= rDao.selectCategoryListCount(conn, categoryNo);
		close(conn);
		return categoryListCount;
	}

	//레시피상세 조회
	public Recipe selectDetailRecipe(int recipeNo) {
		Connection conn = getConnection();
		Recipe detailRecipe = rDao.selectDetailRecipe(conn, recipeNo);
		close(conn);
		return detailRecipe;
	
	}
	
	//레시피 재료
	public List<Recipe> selectIngridient(int recipeNo) {
		Connection conn = getConnection();
		List<Recipe> ingredient = rDao.selectIngridient(conn, recipeNo);
		close(conn);
		return ingredient;
		
	}

	public List<Recipe> selectStep(int recipeNo) {
		Connection conn = getConnection();
		List<Recipe> step= rDao.selectStep(conn, recipeNo);
		close(conn);
		return step;

	}
	
	
	public List<OrderProduct> selectOrderProduct(int userNo) {
		Connection conn = getConnection();
		List<OrderProduct> orderProduct= rDao.selectOrderProduct(conn, userNo);
		close(conn);
		return orderProduct;

	}

	public int insertStepList(int step) {
		Connection conn = getConnection();
		int stepResult= rDao.insertStepList(conn, step);
		close(conn);
		return stepResult;
	}

	public int insertIngredientList(int ingredient) {
		Connection conn = getConnection();
		int ingredientResult= rDao.insertIngredientList(conn, ingredient);
		close(conn);
		return ingredientResult;
	}
	

	
	}


