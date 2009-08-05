module MissionariosHelper
  def paroquias_sufraganeas
    if session[:usuario_id]
      usuario = Usuario.find(session[:usuario_id])
      # Garante que o cara existe
      if usuario.missionario && usuario.missionario.cargo
        case usuario.missionario.cargo.nivel
        when 1 #coordenador de vicariato
          return [] << usuario.missionario.paroquia.forania.vicariato.paroquias
        when 2 #coordenador de forania
          return [] << usuario.missionario.paroquia.forania.paroquias
        when 3 #coordenador de paróquia
          return [] << usuario.missionario.paroquia
        end
      end
    end
    return Paroquia.find(:all)
  end

  def fields_for_telefone(telefone,&block)
    prefix = telefone.new_record? ? 'novo' : 'existe'
    fields_for "missionario[#{prefix}_telefone_attributes][]", telefone, &block
  end

  def maisum_telefone(fone)
    link_to_function fone do |page|
      page.insert_html :bottom, :telefones, :partial => 'telefone'
    end
  end
end
