class ArticlesController < ActionController::Base

    def show
        @artigo = Article.find(params[:id])
    end

    def index
        @artigos = Article.all
    end

    def new
        @artigo = Article.new()
    end

    def edit
        @artigo = Article.find(params[:id])
    end

    def create
        @artigo = Article.new(params.require(:article).permit(:title, :description))
        if @artigo.save
            puts flash[:notice] = "Artigo foi salvo com sucesso!"
            redirect_to article_path(@artigo)
        else
            render 'new'
        end
    end

    def update
        @artigo = Article.find(params[:id])
        if @artigo.update(params.require(:article).permit(:title, :description))
            redirect_to article_path(@artigo)
        else
            render 'edit'
        end
    end

end
