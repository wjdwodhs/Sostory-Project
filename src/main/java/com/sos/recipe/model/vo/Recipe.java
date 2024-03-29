package com.sos.recipe.model.vo;

import java.sql.Date;

public class Recipe {
	private int recipeNo;
	private int userNo;
	private int productNo;
	private String recipeTitle;
	private String thumbnailUrl;
	private String recipeIntro;
	private String difficulty;
	private int serving;
	private int cookingTime;
	private Date postDate;
	private String status;
	
	//category
	private String categoryName;
	private int categoryNo;

	//Member
	private String userName;
	private String userPath;
	
	//like
	private int likeRefno;
	private int likeCount;
	
	//product
	private String productName;
	private int price;
	private int discountPrice;
	private String path;
	
	//RECIPE_INGREDIENT
	private String ingredientName;
	private int ingredientAmount;
	private int ingredientCount;
	private String ingredientUnit;

	//STEP
	private int stepNo;
	private String stepContent;
	private String stepAttachmentUrl;
	private int stepCount; //이렇게 하는거 맞dk..?

	
	

	public Recipe() {
		
	}

	 //레시피 조회
	public Recipe(int recipeNo, String categoryName, String recipeTitle, String thumbnailUrl, String recipeIntro,
			String userName, String userPath, int likeCount, String productName, int price, int discountPrice,
			String path) {
		super();
		this.recipeNo = recipeNo;
		this.categoryName = categoryName;
		this.recipeTitle = recipeTitle;
		this.thumbnailUrl = thumbnailUrl;
		this.recipeIntro = recipeIntro;
		this.userName = userName;
		this.userPath = userPath;
		this.likeCount = likeCount;
		this.productName = productName;
		this.price = price;
		this.discountPrice = discountPrice;
		this.path = path;
	}


	public Recipe(int recipeNo, int userNo, int productNo, String recipeTitle, String thumbnailUrl, String recipeIntro,
			String difficulty, int serving, int cookingTime, Date postDate, String status, String categoryName,
			int categoryNo, String userName, String userPath, int likeRefno, String productName, int price,
			int discountPrice, String path) {
		super();
		this.recipeNo = recipeNo;
		this.userNo = userNo;
		this.productNo = productNo;
		this.recipeTitle = recipeTitle;
		this.thumbnailUrl = thumbnailUrl;
		this.recipeIntro = recipeIntro;
		this.postDate = postDate;
		this.status = status;
		this.categoryName = categoryName;
		this.categoryNo = categoryNo;
		this.userName = userName;
		this.userPath = userPath;
		this.likeRefno = likeRefno;
		this.productName = productName;
		this.price = price;
		this.discountPrice = discountPrice;
		this.path = path;
	}

	//레시피 상세
	public Recipe(int recipeNo, int userNo, String categoryName, String recipeTitle, String thumbnailUrl, String recipeIntro, String difficulty, int serving, int cookingTime,
			String userName, String userPath, int likeCount, String productName, int price, int discountPrice,
			String path) {
		super();
		this.recipeNo = recipeNo;
		this.userNo = userNo;
		this.categoryName = categoryName;
		this.recipeTitle = recipeTitle;
		this.thumbnailUrl = thumbnailUrl;
		this.recipeIntro = recipeIntro;
		this.difficulty = difficulty;
		this.serving = serving;
		this.cookingTime = cookingTime;
		this.userName = userName;
		this.userPath = userPath;
		this.likeCount = likeCount;
		this.productName = productName;
		this.price = price;
		this.discountPrice = discountPrice;
		this.path = path;
		
	}

	
	//레시피 상세 - step
	public Recipe(int recipeNo, int stepNo, int stepCount, String stepContent, String stepAttachmentUrl) {
		super();
		this.recipeNo = recipeNo;
		this.stepNo = stepNo;
		this.stepCount = stepCount;
		this.stepContent = stepContent;
		this.stepAttachmentUrl = stepAttachmentUrl;

	}	
	
	//레시피 재료
	public Recipe(int recipeNo, String ingredientName, int ingredientAmount, String ingredientUnit, int ingredientCount) {
		super();
		this.recipeNo = recipeNo;
		this.ingredientName = ingredientName;
		this.ingredientAmount = ingredientAmount;
		this.ingredientUnit = ingredientUnit;
		this.ingredientCount = ingredientCount;
	}


	//등록
	public Recipe(int categoryNo, int userNo, int productNo, String recipeTitle, String thumbnailUrl, String recipeIntro,
			 int serving,  int cookingTime, String difficulty) {
		super();
		this.categoryNo = categoryNo;
		this.userNo = userNo;
		this.productNo = productNo;
		this.recipeTitle = recipeTitle;
		this.thumbnailUrl = thumbnailUrl;
		this.recipeIntro = recipeIntro;
		this.serving = serving;
		this.difficulty = difficulty;
		this.cookingTime = cookingTime;
	}
	
	

	public String getIngredientUnit() {
		return ingredientUnit;
	}

	public void setIngredientUnit(String ingredientUnit) {
		this.ingredientUnit = ingredientUnit;
	}

	public int getIngredientAmount() {
		return ingredientAmount;
	}
	
	public void setIngredientAmount(int ingredientAmount) {
		this.ingredientAmount = ingredientAmount;
	}

	public int getLikeCount() {
		return likeCount;
	}


	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getStepCount() {
		return stepCount;
	}


	public String getIngredientName() {
		return ingredientName;
	}


	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}



	public int getIngredientCount() {
		return ingredientCount;
	}


	public void setIngredientCount(int ingredientCount) {
		this.ingredientCount = ingredientCount;
	}



	public void setStepCount(int stepCount) {
		this.stepCount = stepCount;
	}


	public int getStepNo() {
		return stepNo;
	}



	public void setStepNo(int stepNo) {
		this.stepNo = stepNo;
	}


	public String getStepContent() {
		return stepContent;
	}


	public void setStepContent(String stepContent) {
		this.stepContent = stepContent;
	}


	public String getStepAttachmentUrl() {
		return stepAttachmentUrl;
	}


	public void setStepAttachmentUrl(String stepAttachmentUrl) {
		this.stepAttachmentUrl = stepAttachmentUrl;
	}


	

	public int getRecipeNo() {
		return recipeNo;
	}


	public void setRecipeNo(int recipeNo) {
		this.recipeNo = recipeNo;
	}


	public int getUserNo() {
		return userNo;
	}


	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}


	public int getProductNo() {
		return productNo;
	}


	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}


	public String getRecipeTitle() {
		return recipeTitle;
	}


	public void setRecipeTitle(String recipeTitle) {
		this.recipeTitle = recipeTitle;
	}


	public String getThumbnailUrl() {
		return thumbnailUrl;
	}


	public void setThumbnailUrl(String thumbnailUrl) {
		this.thumbnailUrl = thumbnailUrl;
	}


	public String getRecipeIntro() {
		return recipeIntro;
	}


	public void setRecipeIntro(String recipeIntro) {
		this.recipeIntro = recipeIntro;
	}


	public String getDifficulty() {
		return difficulty;
	}


	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}


	public int getServing() {
		return serving;
	}


	public void setServing(int serving) {
		this.serving = serving;
	}


	public int getCookingTime() {
		return cookingTime;
	}


	public void setCookingTime(int cookingTime) {
		this.cookingTime = cookingTime;
	}


	public Date getPostDate() {
		return postDate;
	}


	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getCategoryName() {
		return categoryName;
	}


	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}


	public int getCategoryNo() {
		return categoryNo;
	}


	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getUserPath() {
		return userPath;
	}


	public void setUserPath(String userPath) {
		this.userPath = userPath;
	}


	public int getLikeRefno() {
		return likeRefno;
	}


	public void setLikeRefno(int likeRefno) {
		this.likeRefno = likeRefno;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getDiscountPrice() {
		return discountPrice;
	}


	public void setDiscountPrice(int discountPrice) {
		this.discountPrice = discountPrice;
	}


	public String getPath() {
		return path;
	}


	public void setPath(String path) {
		this.path = path;
	}


	public String getIngridientName() {
		return ingredientName;
	}


	public void setIngridientName(String ingridientName) {
		this.ingredientName = ingridientName;
	}

	@Override
	public String toString() {
		return "Recipe [recipeNo=" + recipeNo + ", userNo=" + userNo + ", productNo=" + productNo + ", recipeTitle="
				+ recipeTitle + ", thumbnailUrl=" + thumbnailUrl + ", recipeIntro=" + recipeIntro + ", difficulty="
				+ difficulty + ", serving=" + serving + ", cookingTime=" + cookingTime + ", postDate=" + postDate
				+ ", status=" + status + ", categoryName=" + categoryName + ", categoryNo=" + categoryNo + ", userName="
				+ userName + ", userPath=" + userPath + ", likeRefno=" + likeRefno + ", likeCount=" + likeCount
				+ ", productName=" + productName + ", price=" + price + ", discountPrice=" + discountPrice + ", path="
				+ path + ", ingredientName=" + ingredientName + ", ingredientAmount=" + ingredientAmount
				+ ", ingredientCount=" + ingredientCount + ", ingredientUnit=" + ingredientUnit + ", stepNo=" + stepNo
				+ ", stepContent=" + stepContent + ", stepAttachmentUrl=" + stepAttachmentUrl + ", stepCount="
				+ stepCount + "]";
	}





}
