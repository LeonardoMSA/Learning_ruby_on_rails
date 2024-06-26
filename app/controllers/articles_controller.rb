class ArticlesController < ActionController::Base
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def show
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new()
    end

    def edit
    end

    def create
        @article = Article.new(params_require)
        if @article.save
            puts flash[:notice] = "Artigo foi salvo com sucesso!"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end

    def update
        if @article.update(params_require)
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy

        @article.destroy
        redirect_to articles_path

    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def params_require
        params.require(:article).permit(:title, :description)
    end


end
