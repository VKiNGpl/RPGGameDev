LoadLibrary("Renderer")
LoadLibrary('Sprite')
LoadLibrary('Texture')
LoadLibrary('System')

gRenderer = Renderer:Create()

gDisplayWidth = System.ScreenWidth()
gDisplayHeight = System.ScreenHeight()

gGrassSprite = Sprite:Create()
gGrassTexture = Texture.Find("grass_center_1")

gTileWidth = gGrassTexture:GetWidth()
gTileHeight = gGrassTexture:GetHeight()
gTilesPerRow = math.ceil(gDisplayWidth / gTileWidth)
gTilesPerCollumn = math.ceil(gDisplayHeight / gTileHeight)
gLeft = -System.ScreenWidth() / 2 + gTileWidth / 2
gTop = System.ScreenHeight() / 2 - gTileHeight / 2

gGrassDirtTLSprite = Sprite:Create()
gGrassDirtTLTexture = Texture.Find('grass_dirt_TL')
gGrassDirtTOPSprite = Sprite:Create()
gGrassDirtTOPTexture = Texture.Find('grass_dirt_TOP')

gGrassSprite:SetTexture(gGrassTexture)
gGrassDirtTLSprite:SetTexture(gGrassDirtTLTexture)
gGrassDirtTOPSprite:SetTexture(gGrassDirtTOPTexture)

function update()
    gGrassDirtTLSprite:SetPosition(gLeft, gTop)
    gRenderer:DrawSprite(gGrassDirtTLSprite)

    for i = 1, gTilesPerRow - 1 do
        gGrassDirtTOPSprite:SetPosition(gLeft + i * gTileWidth, gTop)
        gRenderer:DrawSprite(gGrassDirtTOPSprite)
    end
end