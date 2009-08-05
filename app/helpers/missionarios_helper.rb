module MissionariosHelper
  def paroquias_sufraganeas
    if session[:usuario_id]
      usuario = Usuario.find(session[:usuario_id])
      case usuario.missionario.cargo.nivel
        when 1 #coordenador de vicariato
        return [] << usuario.missionario.paroquia.forania.vicariato.paroquias
        when 2 #coordenador de forania
        return [] << usuario.missionario.paroquia.forania.paroquias
        when 3 #coordenador de paróquia
        return [] << usuario.missionario.paroquia
      end
    end
    return Paroquia.find(:all)
  end
end
