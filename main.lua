LoadLibrary("Renderer")
LoadLibrary('Sprite')
LoadLibrary('Texture')
LoadLibrary('System')

gRenderer = Renderer:Create()

gTileSprite = Sprite:Create()
gGrassTexture = Texture.Find("grass_tile.png")
gTileWidth = gGrassTexture:GetWidth()
gTileHeight = gGrassTexture:GetHeight()

gLeft = -System.ScreenWidth() / 2 + gTileWidth / 2
gTop = System.ScreenHeight() / 2 - gTileHeight / 2

gDisplayWidth = System.ScreenWidth()
gDisplayHeight = System.ScreenHeight()

gTilesPerRow = math.ceil(gDisplayWidth / gTileWidth)
gTilesPerCollumn = math.ceil(gDisplayHeight / gTileHeight)

gTileSprite:SetTexture(gGrassTexture)

function update()
    for i = 0, gTilesPerRow - 1 do
        gTileSprite:SetPosition(gLeft + i * gTileWidth, gTop)
        gRenderer:DrawSprite(gTileSprite)
    end
end