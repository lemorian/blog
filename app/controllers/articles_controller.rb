class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  def new
    @article = Article.new
  end

  def set_article
    @article = Article.find(params[:id])
 end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

 

  def update

    if @article.update(article_params)
      flash[:success]= "Article was updated"
      redirect_to article_path(@article)
    else
      flash[:success]= "Article was not updated"
      render "edit"
    end
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    
    @article.destroy
    flash[:success]= "Article was deleted"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
