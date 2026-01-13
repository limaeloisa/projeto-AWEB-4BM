-- ===================================================
-- BANCO DE DADOS - SISTEMA BLOG PUREZA
-- ===================================================

CREATE DATABASE IF NOT EXISTS sistemablog;
USE sistemablog;

-- ===================================================
-- TABELA: CATEGORIAS
-- ===================================================
CREATE TABLE IF NOT EXISTS categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    icone VARCHAR(50),
    cor VARCHAR(7),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===================================================
-- TABELA: AUTORES
-- ===================================================
CREATE TABLE IF NOT EXISTS autores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    bio VARCHAR(500),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===================================================
-- TABELA: POSTS/CONTEÚDO
-- ===================================================
CREATE TABLE IF NOT EXISTS posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    descricao VARCHAR(500),
    conteudo LONGTEXT NOT NULL,
    imagem VARCHAR(500),
    categoria_id INT NOT NULL,
    autor_id INT,
    ativo BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE,
    FOREIGN KEY (autor_id) REFERENCES autores(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===================================================
-- INSERIR CATEGORIAS
-- ===================================================
INSERT INTO categorias (nome, descricao, icone, cor) VALUES
('história', 'História e origem de Pureza', '📚', '#0a7ea4'),
('lendas', 'Lendas e mitos locais', '⭐', '#2e7d32'),
('turismo', 'Pontos turísticos e destinos', '🏔️', '#0277bd'),
('cultura', 'Cultura e tradições', '🎨', '#f57f17'),
('pau-brasil', 'História do Pau Brasil', '🌳', '#00897b'),
('causos', 'Causos e histórias populares', '😄', '#ff6f00');

-- ===================================================
-- INSERIR AUTOR PADRÃO
-- ===================================================
INSERT INTO autores (nome, email, senha, bio) VALUES
('Sistema Pureza', 'sistema@pureza.com', '12345', 'Sistema automático de conteúdo');

-- ===================================================
-- INSERIR HISTÓRIAS
-- ===================================================
INSERT INTO posts (titulo, slug, descricao, conteudo, imagem, categoria_id, autor_id, ativo) VALUES
(
    'Primeiros Habitantes Indígenas',
    'primeiros-habitantes',
    'A história dos Tapuios e a presença indígena em Pureza',
    '<h2>A Tribo Tapuia: Os Primeiros Habitantes</h2><p>Sobre o passado indígena purezense, pesquisadores afirmam a existência da tribo indígena conhecida como Tapuios, também chamados de caboclinhos. Muito valentes e organizados, os Tapuios, segundo relatos, moravam abaixo do chão, habitando galerias subterrâneas. Saíam apenas à noite para buscar água e se alimentar.</p><p>Conta-se que um morador de Pureza teria descoberto duas moradias desses indígenas: uma localizada na fonte, onde hoje funciona o Centro de Turismo, e outra na residência de um antigo morador da cidade.</p><p>O termo tapuio é uma expressão de origem tupi, derivada de <em>tapuy-ú</em>, que significa "o gentio bárbaro" ou "aquele que vive isolado".</p><h3>Estruturas das Moradias Indígenas</h3><p>Segundo os moradores mais antigos, as residências indígenas encontradas em Pureza possuíam a mesma estrutura das construídas pelos Suçuatins em Boa Cica, município de Touros/RN. Essa semelhança reforça a presença indígena na região.</p><p>A presença de índios em Pureza também é mencionada no livro de Nilson Patriota, que escreve sobre os indígenas de Boa Cica e sobre tribos espalhadas por povoados ainda pouco conhecidos.</p><h3>Registros Históricos e Cartográficos</h3><p>De acordo com registros históricos sobre os Suçuatins, o conhecimento dessa tribo se deu a partir da descoberta de um mapa confeccionado em 1579, em Dieppe, na França, pelo cartógrafo Jacques Vaudeciey. Supõe-se que o cartógrafo tenha permanecido por um longo período no Nordeste brasileiro, já que o mapa apresenta detalhes minuciosos sobre áreas propícias à invasão francesa.</p><p>O documento cita regiões correspondentes aos atuais estados do Ceará, Rio Grande do Norte, Paraíba e Pernambuco, demonstrando conhecimento tanto das tribos potiguares do litoral quanto das que habitavam o interior, identificadas como pertencentes ao "reino das nações Tapuias".</p><h3>Vestígios Arqueológicos em Pureza</h3><p>Moradores mais antigos afirmam que existiam moradias indígenas no Tabuleiro, no Cururu e em Tapera. Essas habitações eram grutas escavadas no chão, com várias entradas. Após observações antropológicas nesses locais, foram encontrados utensílios de uso doméstico, como panelas de barro, cachimbos e outros objetos.</p><h3>O Extermínio Indígena no Rio Grande do Norte</h3><p>O extermínio dos povos indígenas no Rio Grande do Norte teve início, em maior proporção, no século XVII. A guerra entre portugueses e holandeses, somada a outros fatores, forçou a migração de grandes contingentes indígenas para regiões como a Paraíba e, principalmente, o Ceará.</p><p>Ao tratar do declínio da população indígena, a professora Fátima Lopes afirma que, segundo informações de jesuítas entre o início da colonização e o século XVIII, havia uma grande concentração de indígenas no litoral do estado. Somente nas proximidades de Natal existiam cerca de 6 mil indígenas, distribuídos em aproximadamente 100 aldeias.</p><p>Em 1603, vinte e seis aldeias potiguares já haviam desaparecido. Em 1613, esse número caiu para apenas oito aldeias. Em 1627, Domingos da Veiga Cabral relatou a existência de pouco mais de 300 flecheiros, divididos em quatro aldeias.</p><h3>Resistência e Ressurgência Cultural</h3><p>Muitas dessas histórias se perderam no tempo, pois tribos inteiras foram dizimadas por colonizadores e fazendeiros que cobiçavam suas terras. Em Pureza, o processo não foi diferente.</p><p>Entretanto, após a promulgação da Constituição Federal de 1988, comunidades indígenas e quilombolas passaram a retomar suas identidades culturais de forma gradual, por meio de movimentos de autoafirmação. Esse processo de ressurgência dos povos historicamente dizimados merece maior aprofundamento, pois evidencia a força da resistência cultural e histórica.</p>',
    'https://via.placeholder.com/600x400?text=Indígenas+Tapuia',
    1, 1, TRUE
),
(
    'Lei de Fundação Municipal',
    'lei-fundacao-municipal',
    'Lei nº 2.882 de 05 de abril de 1963 - Criação de Pureza',
    '<h2>A Criação do Município de Pureza</h2><p>O governador Aluísio Alves era o gestor do Rio Grande do Norte à época em que foi aprovada a fundação do município de Pureza. Após a autonomia política, foram marcados os seus limites territoriais.</p><p>A Lei nº 2.882, de 05 de abril de 1963, em seu artigo 1º, trata da criação do município de Pureza. O documento afirma que o território deve desmembrar de Touros, passando à categoria de cidade, sendo que o poder judiciário ficaria inicialmente subordinado à Comarca de Touros.</p><h3>Limites Territoriais</h3><p>O artigo 2º estabelece que o novo município teria os seguintes limites: começa do povoado de "Cana Brava", inclusive, numa linha reta vai ter a fazenda "Bebida Velha" e, daí, a foz do rio "Lagoa da Prata", por cujo leito prossegue até a confluência dos limites intermunicipais de Touros e Maxaranguape, passando entre as fazendas "Fonseca" e "Dr. Reinaldo Bezerril"; continua pelos limites citados, até atingir o rio "Maxaranguape", no lugar denominado "Barra do Riacho"; segue daí, pelo "Riacho Seco", até alcançar o leito da estrada que liga João Câmara a Touros; prossegue por essa estrada e vai ter ao povoado dos limites descritos neste artigo.</p><h3>Instalação e Administração</h3><p>O artigo 3º aponta que o novo município instalar-se-ia 30 (trinta) dias após a publicação da referida Lei, sendo administrado inicialmente por um Prefeito de livre nomeação do Governador do Estado, até que se realizassem eleições democráticas para o cargo de prefeito, vice-prefeito e vereadores.</p><h3>Recursos Financeiros</h3><p>O artigo 4º estabelece, para fazer face às despesas com a instalação do novo município, que fica o Poder Executivo autorizado a abrir, no corrente exercício, o crédito especial de R$ 500.000,00 (quinhentos mil cruzeiros), constituindo recursos para cobertura da despesa.</p><h3>Localização Geográfica</h3><p>De acordo com o artigo 5º, a Lei de criação do município de Pureza entrou em vigor na data de sua publicação, revogadas as disposições em contrário. O local da publicação foi o Palácio da Esperança, em Natal, no dia 5 de abril de 1963.</p><p>O novo município se localiza na mesorregião Leste Potiguar e na microrregião Litoral Nordeste do estado do Rio Grande do Norte. As suas coordenadas geográficas são: Latitude Sul 05° 28'' 01,20" e Longitude Oeste 35° 33'' 21,60". O município com área de 504,26 km², equivalente a 0,95% da superfície estadual, e com população de 9.515 habitantes, está localizado a uma distância de 60 km da cidade de Natal, capital do Rio Grande do Norte.</p><p>O território municipal faz fronteira, ao Norte, com Touros; ao Sul, com Taipu, Poço Branco e João Câmara; a Leste, com Maxaranguape; e a Oeste, com Touros e João Câmara.</p>',
    'https://via.placeholder.com/600x400?text=Lei+Fundação',
    1, 1, TRUE
),
(
    'Significado do Brasão Municipal',
    'brasao-municipal',
    'Símbolos e significados do brasão de Pureza',
    '<h2>Os Símbolos do Brasão</h2><p>No brasão do município de Pureza estão representados símbolos que caracterizam sua origem, suas atividades econômicas e seu potencial turístico. A gruta de Pureza, integrada à fonte de água cristalina, perene e de propriedades medicinais, representa um dos maiores patrimônios naturais do município, destacando-se pelo seu grande potencial turístico.</p><h3>Elementos Constituintes</h3><p>A imagem central do brasão é moldurada por árvores de pau-ferro, símbolo da resistência e da força da natureza local. A faixa amarela, presente na composição, traz o nome geográfico do município, enquanto no plano de fundo da faixa observa-se uma catraca, elemento que simboliza a presença histórica dos engenhos de cana-de-açúcar e a importância da atividade agroindustrial para o desenvolvimento local.</p><h3>Significado Poético e Simbólico</h3><p>O brasão municipal busca transmitir uma imagem poética, carregada de simbolismo, representando abundância, fertilidade e tranquilidade, características marcantes do município de Pureza.</p><h3>Potencial Agroeconômico</h3><p>As águas subterrâneas do município irrigam o leito do Rio Maxaranguape, transformando as terras adjacentes em um vale úmido de elevada fertilidade. Culturas como cana-de-açúcar, macaxeira e bananeira configuram-se como pilares do celeiro agroeconômico do município.</p>',
    'https://via.placeholder.com/600x400?text=Brasão+Pureza',
    1, 1, TRUE
),
(
    'Significações da Bandeira Municipal',
    'bandeira-municipal',
    'Os símbolos e história da bandeira de Pureza',
    '<h2>A Bandeira Municipal de Pureza</h2><p>A bandeira municipal de Pureza é composta por um retângulo branco, sobre o qual se destaca uma cruz azul que se entrecruza ao centro, tendo ao fundo a imagem do brasão do município. O conjunto simbólico remete à fé cristã e presta homenagem à Nossa Senhora da Pureza, padroeira do município.</p><h3>Processo de Criação</h3><p>Em ofício encaminhado ao então prefeito em exercício, Sr. João da Fonseca Moura Neto, no dia 05 de dezembro de 2005, a Sra. Anadite Fernandes da Silva, responsável pela execução do Projeto de Criação das Bandeiras no Rio Grande do Norte, propôs uma alteração no brasão da nova bandeira, a qual foi acatada.</p><h3>Aprovação Legislativa</h3><p>O Projeto de Lei foi protocolado na Câmara Municipal em 08 de março de 2006, votado em 15 de março de 2006 e aprovado por unanimidade pelos vereadores: José Bezerra de Araújo (Presidente da Câmara), Maria do Socorro Varela de Araújo, Magnus Kelly Gabriel de Assis, Isaías dos Santos, Maria Gomes de Oliveira Brito, Raimundo Alves de Oliveira, José Barbosa, João da Silveira Damasceno e José Lindauro Xavier.</p><p>Dessa forma, foi instituído o Projeto de Lei nº 227/06, de 15 de março de 2006, que oficializou a criação do novo Brasão e da Bandeira do Município de Pureza.</p>',
    'https://via.placeholder.com/600x400?text=Bandeira+Pureza',
    1, 1, TRUE
),
(
    'A Era do Pau Brasil',
    'pau-brasil',
    'O ciclo econômico que moldou Pureza',
    '<h2>O Ciclo do Pau Brasil</h2><p>Durante os séculos XVI e XVII, a extração de pau brasil foi a principal atividade econômica. As florestas de Pureza foram exploradas, deixando marcas na paisagem e na cultura local.</p><h3>Importância Econômica</h3><p>O pau brasil era ouro vermelho. Exportado para a Europa, sua madeira vermelha era usada para tingimento de tecidos de luxo. Isso atraiu jesuítas, bandeirantes e comerciantes.</p><h3>Impacto Ambiental</h3><p>A exploração intensiva devastou as florestas originais. Apenas pequenas parcelas de floresta com pau brasil sobrevivem hoje em dia, protegidas por leis ambientais.</p><h3>Legado Cultural</h3><p>O pau brasil deixou uma marca profunda na identidade de Pureza. Nomes de ruas, festas e tradições ainda fazem referência a esse período histórico importante.</p>',
    'https://via.placeholder.com/600x400?text=Pau+Brasil',
    5, 1, TRUE
);


-- ===================================================
-- INSERIR LENDAS
-- ===================================================
INSERT INTO posts (titulo, slug, descricao, conteudo, imagem, categoria_id, autor_id, ativo) VALUES
(
    'A Fonte Encantada',
    'fonte-encantada',
    'A lenda das águas cristalinas e o ouro encantado',
    '<h2>A Lenda da Fonte Encantada</h2><p>A Fonte Encantada é uma das lendas mais antigas e sagradas de Pureza. Relata que as águas cristalinas que brotam da fonte seriam forradas de ouro puro, mantendo sua beleza e pureza através de um encantamento ancestral.</p><p>Diz-se que, se alguém tentar retirar o ouro da fonte, ela secará para sempre, pois é protegida por forças mágicas que garantem sua perenidade.</p><p>Os moradores antigos contam que a fonte é um presente dos deuses da natureza, uma bênção que deve ser respeitada e preservada. Aqueles que tentaram desafiar o encantamento sofreram maldições e desgraças.</p><p>A Fonte Encantada permanece como um símbolo de respeito à natureza e à sabedoria ancestral, recordando gerações que algumas riquezas não podem ser medidas em ouro, mas na beleza e pureza da vida.</p>',
    'https://via.placeholder.com/600x400?text=Fonte+Encantada',
    2, 1, TRUE
),
(
    'A Galinha dos Pintinhos de Ouro',
    'galinha-ouro',
    'A criatura mítica que guarda tesouros na gruta',
    '<h2>A Galinha dos Pintinhos de Ouro</h2><p>Uma das lendas mais encantadoras de Pureza relata a existência de uma galinha extraordinária que vive nas profundezas da gruta. Não é uma galinha comum, mas uma criatura mágica com pintinhos feitos de ouro puro.</p><p>Segundo os relatos, a galinha aparece apenas por breves instantes, geralmente nas noites de lua cheia, quando se move entre as cavernas. Alguns moradores juram tê-la visto, descrevendo seu brilho dourado que ilumina a escuridão da gruta.</p><p>A Galinha dos Pintinhos de Ouro é protegida por uma grande pedra encantada que a mantém oculta. Diz-se que quem conseguir vê-la será agraciado com boa sorte e fortuna, mas apenas se não tentar capturá-la.</p><p>Essa lenda representa a riqueza natural e o mistério da natureza, lembrando que nem tudo que brilha pode ser possuído, e que a verdadeira riqueza está em apreciar a beleza dos mistérios da vida.</p>',
    'https://via.placeholder.com/600x400?text=Galinha+Ouro',
    2, 1, TRUE
),
(
    'A Mãe-d\'Água',
    'mae-dagua',
    'A figura mística das águas cristalinas',
    '<h2>A Lenda da Mãe-d\'Água</h2><p>A Mãe-d\'Água é uma figura mística que segundo a lenda local, visita a fonte de Pureza. Poucos afirmam tê-la visto, pois sua aparição é rara e cercada de mistério. Aqueles que tiveram a rara oportunidade descrevem uma bela morena penteando longos cabelos negros negros brilhantes como a própria água.</p><p>A Mãe-d\'Água representa a essência e o espírito das águas cristalinas. Seu encontro causa grande medo e admiração simultâneos, uma mistura de respeito pela força sobrenatural e pela beleza hipnotizante da entidade.</p><p>Segundo a tradição oral, ela surge em noites tranquilas, geralmente perto de amanhecer, quando as águas estão mais calmas e cristalinas. Diz-se que ela protege a fonte de desrespeitos e castiga aqueles que poluem ou destroem seu habitat.</p><p>A lenda da Mãe-d\'Água é um lembrete da importância de respeitar os recursos naturais e reconhecer a presença de forças misteriosas que permeiam a natureza.</p>',
    'https://via.placeholder.com/600x400?text=Mãe+dAgua',
    2, 1, TRUE
),
(
    'Fogo Batatão',
    'fogo-batatao',
    'A bola de fogo misteriosa que assustava os antigos',
    '<h2>A Lenda do Fogo Batatão</h2><p>O Fogo Batatão é uma das lendas mais assustadoras de Pureza, que relata o aparecimento de uma bola de fogo misteriosa nos matos e campos ao redor do município. Descrito como um fenômeno sobrenatural, essa bola de fogo mudava de lugar repentinamente, desaparecendo e reaparecendo sem aviso.</p><p>Os moradores antigos contam histórias de pânico quando o Fogo Batatão surgia durante as noites. Alguns afirmam que ele tinha inteligência própria, fugindo de quem o perseguia e assustando os incautos que se atravessavam em seu caminho.</p><p>Existem várias teorias sobre a origem do Fogo Batatão. Alguns acreditam que seria a manifestação de um espírito penado, outros argumentam ser um fenômeno natural mal compreendido pela população da época.</p><p>Embora as aparições do Fogo Batatão tenham se tornado raras nos tempos modernos, a lenda persiste na memória coletiva de Pureza, servindo como lembrete dos mistérios e fenômenos ainda não totalmente explicados pela ciência.</p>',
    'https://via.placeholder.com/600x400?text=Fogo+Batatão',
    2, 1, TRUE
),
(
    'O Redemoinho',
    'redemoinho',
    'O vento sobrenatural que assustava a população',
    '<h2>O Redemoinho Misterioso</h2><p>O Redemoinho é um fenômeno sobrenatural representado por um vento forte e repentino que aparecia e desaparecia sem aviso, levando tudo pela frente. Diferente dos redemoinhos naturais, esse fenômeno era acompanhado de uma sensação de presença sobrenatural.</p><p>Segundo relatos dos antigos, o Redemoinho surgia em dias aparentemente calmos, sem nuvens no céu. Seu aparecimento era abrupto e imprevisível, criando pânico entre os moradores que se viam em seu caminho.</p><p>Descrições variam de uma figura envolvida por vento negro a uma força invisível que carregava tudo à sua volta. Alguns dizem ter ouvido vozes uivando dentro do redemoinho, sugerindo uma entidade consciente e malévola.</p><p>A tradição oral sugere que o Redemoinho seria a manifestação de uma maldição ou a presença de um espírito descontente. Rituais de proteção e oferendas passaram a fazer parte da cultura local como forma de apaziguar essa força.</p>',
    'https://via.placeholder.com/600x400?text=Redemoinho',
    2, 1, TRUE
),
(
    'O Lobisomem',
    'lobisomem',
    'A lenda do homem que se transforma em fera',
    '<h2>A Lenda do Lobisomem de Pureza</h2><p>A lenda do Lobisomem é uma das mais clássicas do folclore nordestino e também está presente na tradição oral de Pureza. Conta a história de um homem e uma mulher que se transformariam em lobisomens nas noites de lua cheia, espalhando medo e terror entre os moradores.</p><p>Segundo relatos, essas criaturas possuíam aspecto assustador, com características tanto humanas quanto animais. Saíam à noite atacando animais de criação e causando destruição, levando pânico aos que as encontravam.</p><p>A tradição oral sugere várias origens para o Lobisomem: filhos sétimos de sétimos, pessoas amaldiçoadas por bruxarias, ou até mesmo seres que venderam a alma ao demônio para ganhar poder.</p><p>Embora as aparições do Lobisomem sejam cada vez mais raras, a lenda persiste como parte importante do patrimônio cultural imaterial de Pureza, representando o medo do desconhecido e da natureza selvagem que rodeia os humanos.</p>',
    'https://via.placeholder.com/600x400?text=Lobisomem',
    2, 1, TRUE
),
(
    'Os Índios que Habitavam a Fonte',
    'indios-fonte',
    'A lenda indígena de origem das águas cristalinas',
    '<h2>A Origem Sagrada da Fonte</h2><p>Esta é uma lenda de origem indígena que explica o surgimento das águas cristalinas e do Rio Maxaranguape a partir de um ritual sagrado realizado pela tribo Tapuia. Segundo essa narrativa mítica, a fonte não seria apenas um fenômeno geológico, mas o resultado da intervenção divina e da magia ancestral.</p><p>A lenda relata que os Tapuios realizavam um ritual sagrado nas terras altas, invocando os deuses da natureza para que trouxessem abundância de água e fertilidade às suas terras. Diz-se que os deuses responderam ao chamado, fazendo brotar da terra as águas cristalinas que alimentam Pureza até os dias de hoje.</p><p>Os índios que habitavam a região consideravam a fonte como um local sagrado, um portal entre o mundo material e o espiritual. Oferendas eram feitas regularmente para agradecer aos deuses e manter a vitalidade das águas.</p><p>Essa lenda conecta a história indígena de Pureza com a importância espiritual e ambiental da fonte, sugerindo que o respeito à natureza é o caminho para manter a abundância e a pureza desses recursos extraordinários.</p>',
    'https://via.placeholder.com/600x400?text=Indios+Fonte',
    2, 1, TRUE
)


-- ===================================================
-- INSERIR TURISMO
-- ===================================================
INSERT INTO posts (titulo, slug, descricao, conteudo, imagem, categoria_id, autor_id, ativo) VALUES
(
    'Cachoeira do Véu das Ninfas',
    'cachoeira-veu-ninfas',
    'A mais bela queda de água de Pureza',
    '<h2>Descubra a Cachoeira</h2><p>A Cachoeira do Véu das Ninfas é o destino turístico mais visitado de Pureza. Suas águas cristalinas caem 40 metros em um espetáculo da natureza.</p><h3>Como Chegar</h3><p>A cachoeira fica a 8km do centro de Pureza. Recomenda-se ir com guia local para melhor experiência. O acesso é por trilha ecológica na mata preservada.</p><h3>O Que Fazer</h3><p>Nadar nas piscinas naturais, tirar fotos, piquenique ou simplesmente apreciar a paisagem. A época melhor é na estação chuvosa quando a queda é mais volumosa.</p><h3>Infraestrutura</h3><p>Possui banheiros, área de piquenique e estacionamento. Há guias especializados disponíveis para tours interpretativos sobre a flora e fauna local.</p>',
    'https://via.placeholder.com/600x400?text=Cachoeira',
    3, 1, TRUE
),
(
    'Praia da Água Cristalina',
    'praia-agua-cristalina',
    'Litoral paradisíaco com águas transparentes',
    '<h2>A Praia Mais Linda</h2><p>A Praia da Água Cristalina é famosa por suas águas transparentes onde se enxerga até o fundo. Areia branca e coqueiros completam o cenário paradisíaco.</p><h3>Atividades Aquáticas</h3><p>Perfeita para natação, mergulho e snorquel. A visibilidade excelente permite observar a fauna marinha. Também oferece passeios de barco para ilhas próximas.</p><h3>Serviços</h3><p>Quiosques com bebidas e comidas típicas, aluguel de guarda-sóis e cadeiras de praia. Salva-vidas em período de pico de visitação.</p><h3>Melhor Época</h3><p>Ideal visitar na baixa estação (outubro a março) quando o mar está mais calmo e a praia menos lotada.</p>',
    'https://via.placeholder.com/600x400?text=Praia',
    3, 1, TRUE
),
(
    'Trilha da Floresta Primária',
    'trilha-floresta',
    'Caminhada na mata preservada de Pureza',
    '<h2>Explorar a Floresta</h2><p>A Trilha da Floresta Primária leva através de mata nativa preservada. São 5km de caminhada moderada com diversas cachoeiras e poços ao longo do caminho.</p><h3>Biodiversidade</h3><p>A trilha passa por habitat de várias espécies de aves, mamíferos e plantas. Observação de vida selvagem é garantida com guia especializado.</p><h3>Dificuldade</h3><p>Trilha moderada, recomendada para pessoas com condicionamento físico mínimo. Leva cerca de 3 horas para fazer ida e volta.</p><h3>Equipamento Necessário</h3><p>Leve sapatos de trilha, repelente, protetor solar e muita água. Recomenda-se começar cedo para aproveitar melhor a experiência.</p>',
    'https://via.placeholder.com/600x400?text=Trilha',
    3, 1, TRUE
);


-- ===================================================
-- INSERIR CULTURA
-- ===================================================
INSERT INTO posts (titulo, slug, descricao, conteudo, imagem, categoria_id, autor_id, ativo) VALUES
(
    'Festas Populares',
    'festas-populares',
    'Celebrações tradicionais que animam Pureza',
    '<h2>Festas da Comunidade</h2><p>Pureza tem um calendário rico de festas populares que animam o município. Desde festas religiosas até celebrações folclóricas, há sempre algo acontecendo.</p><h3>Festa de São João</h3><p>Realizada em junho com comidas típicas, danças e fogueira. A festa atrai visitantes de toda região com suas tradições nordestinas.</p><h3>Festa da Água Cristalina</h3><p>Anual em setembro, celebra as águas que tornam Pureza especial. Inclui competições aquáticas, desfiles e shows culturais.</p><h3>Carnaval</h3><p>Pequeno mas vibrante, com blocos temáticos e festa social. A comunidade se reúne para celebrar com música e dança.</p>',
    'https://via.placeholder.com/600x400?text=Festas',
    4, 1, TRUE
),
(
    'Artesanato Local',
    'artesanato-local',
    'Criações e tradições de artesãos purezenses',
    '<h2>Arte e Criatividade</h2><p>Os artesãos de Pureza criam obras primas usando materiais locais. De cerâmica a tecelagem, cada peça conta uma história.</p><h3>Cerâmica</h3><p>Feita com barro da região, as peças refletem motivos da natureza. Potes, tigelas e objetos decorativos são vendidos em lojas locais.</p><h3>Tecelagem</h3><p>Mulheres tecem fios formando tapetes, bolsas e roupas com padrões tradicionais. Cada peça é única e criada à mão.</p><h3>Trabalhos em Madeira</h3><p>Artesãos trabalham madeira de demolição criando móveis rústicos e objetos decorativos. Uma forma de preservar a história enquanto cria algo novo.</p>',
    'https://via.placeholder.com/600x400?text=Artesanato',
    4, 1, TRUE
),
(
    'Gastronomia de Pureza',
    'gastronomia',
    'Sabores autênticos da culinária local',
    '<h2>Comida do Coração</h2><p>A cozinha de Pureza é resultado da mistura de tradições indígenas, coloniais e atuais. Frutos do mar e produtos da terra convertem em pratos memoráveis.</p><h3>Prato Típico: Moqueca de Peixe</h3><p>Preparada com peixe fresco das águas locais, leite de coco, dendê e temperos. Servida em panela de barro, é irresistível.</p><h3>Doces Tradicionais</h3><p>Paçoca de amendoim, bolo de coco e cocada com gosto da vovó. Feitos em pequena escala mantêm a autenticidade.</p><h3>Bebidas</h3><p>Suco de fruta natural, água fresca de coco e um café da manhã reforçado completam a experiência gastronômica.</p>',
    'https://via.placeholder.com/600x400?text=Gastronomia',
    4, 1, TRUE
);

-- ===================================================
-- INSERIR CAUSOS (HISTÓRIAS POPULARES)
-- ===================================================
INSERT INTO posts (titulo, slug, descricao, conteudo, imagem, categoria_id, autor_id, ativo) VALUES
(
    'O Ouro da Hora',
    'ouro-hora',
    'Um causo sobre um mercador e seu ouro mágico',
    '<h2>A História do Ouro da Hora</h2><p>Conta-se em Pureza a história de um velho mercador bem-humorado que viajava pela região vendendo um produto extraordinário: o famoso "ouro da hora".</p><p>O mercador era conhecido por sua lábia e seu sorriso malicioso. Ele aproximava-se dos desavisados oferecendo pequenas quantidades de um pó brilhante que, garantia ele, deixaria a pessoa rica instantaneamente.</p><p>Quem comprava ficava rico apenas naquele momento, pois o ouro falso escurecia rapidamente, revelando-se como uma fraude. Os compradores enganados iam atrás do mercador, mas ele sempre desaparecia no horizonte, deixando risadas pelo caminho.</p><p>Alguns moradores antigos juram que ainda veem o mercador em noites de neblina, oferecendo seu "ouro da hora" a viajantes desavisados. O causo ressalta a importância de desconfiança e sabedoria popular contra os enganadores.</p>',
    'https://via.placeholder.com/600x400?text=Ouro+Hora',
    6, 1, TRUE
),
(
    'A Lara e Eu',
    'lara-eu',
    'Um relato misterioso e mal explicado',
    '<h2>O Mistério da Noite na Fonte</h2><p>Este é um causo que circula entre os jovens de Pureza há muitos anos. Relata a história de um grupo de rapazes que costumavam jogar bola à noite perto da fonte e tomar banho nas águas cristalinas depois de brincar.</p><p>De acordo com a narrativa, em uma dessas noites, quando todos estavam na água se refrescando, algo estranho aconteceu. Uma delas, chamada Lara, começou a desaparecer gradualmente da vista dos amigos, como se estivesse sendo puxada para as profundezas.</p><p>Aqueles que tentaram salvá-la sentiram uma força desconhecida puxando para baixo, e conseguiram escapar apenas com grande esforço. Quando olharam para trás, Lara havia desaparecido completamente nas águas cristalinas.</p><p>O causo termina sem explicação clara do que aconteceu. Alguns dizem que foi a Mãe-d\'Água que a levou. Outros acreditam que foi apenas um acidente mal contado. O fato é que a história permanece envolta em mistério, deixando dúvidas e questionamentos entre aqueles que a ouvem.</p>',
    'https://via.placeholder.com/600x400?text=Lara+Noite',
    6, 1, TRUE
),
(
    'O Casal de Lobisomens',
    'casal-lobisomens',
    'Uma versão bem-humorada e alternativa',
    '<h2>A Verdade Por Trás da Lenda</h2><p>Bem-humorada e cheia de ironia, essa versão popular do causo dos lobisomens revela a verdade que os moradores mais antigos sempre suspeitaram.</p><p>Diz a história que dois jovens apaixonados da região usavam a lenda dos lobisomens como desculpa perfeita para se encontrar secretamente nas noites de lua cheia. Eles saíam de suas casas "fugindo do lobisomem" quando, na verdade, estavam se encontrando em um local isolado para ficar juntos.</p><p>Como os pais acreditavam piamente na lenda do lobisomem, nunca desconfiavam dos "encontros de emergência" dos rapazes. A comunidade inteira vivia com medo, enquanto o casal aproveitava o mistério para viver seu romance escondido.</p><p>Segundo o causo, este ardil funcionou perfeitamente por muitos anos, até que alguns moradores mais perspicazes perceberam que o "lobisomem" aparecia sempre nos mesmos lugares e horários, e curiosamente, desaparecia quando o casal se casava e se mudava da região.</p><p>O causo é uma crítica bem-humorada à credulidade das gerações passadas e à engenhosidade dos jovens apaixonados em contornar as restrições sociais de seu tempo.</p>',
    'https://via.placeholder.com/600x400?text=Lobisomens+Humor',
    6, 1, TRUE
)

-- ===================================================
-- CRIAR ÍNDICES PARA PERFORMANCE
-- ===================================================
CREATE INDEX idx_slug ON posts(slug);
CREATE INDEX idx_categoria ON posts(categoria_id);
CREATE INDEX idx_ativo ON posts(ativo);
CREATE INDEX idx_criado_em ON posts(criado_em DESC);
