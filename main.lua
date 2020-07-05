LoadLibrary("Renderer")
LoadLibrary('Sprite')
LoadLibrary('Texture')
LoadLibrary('System')

gRenderer = Renderer:Create()

gDisplayWidth = System.ScreenWidth()
gDisplayHeight = System.ScreenHeight()

gTileSize = 64
gTileWidth = gTileSize
gTileHeight = gTileSize

gTop = System.ScreenHeight() / 2 - gTileHeight / 2
gLeft = -System.ScreenWidth() / 2 + gTileWidth / 2

function GenerateUVs(texture, tileSize)

    local uvs = {}

    local textureWidth = texture:GetWidth()
    local textureHeight = texture:GetHeight()
    local width = tileSize / textureWidth
    local height = tileSize / textureHeight
    local cols = textureWidth / tileSize
    local rows = textureHeight / tileSize

    local u0 = 0
    local v0 = 0
    local u1 = width
    local v1 = height

    for j = 0, rows - 1 do
        for i = 0, cols - 1 do
            table.insert( uvs, {u0, v0, u1, v1} )
            u0 = u0 + width
            u1 = u1 + width
        end
        u0 = 0
        v0 = v0 + height
        u1 = width
        v1 = v1 + height
    end
    return uvs
end

gTileSprite = Sprite:Create()
gTileTexture = Texture.Find('atlas64')
gTileSprite:SetTexture(gTileTexture)

gUVs = GenerateUVs(gTileTexture, gTileSize)

gMap = {
    1,  2,  3,  4,  3,  4,  5,  6,    -- 1
    41, 42, 43, 44, 43, 44, 45, 46,    -- 2
    81, 82, 83, 84, 83, 84, 85, 86,    -- 3
    41, 42, 43, 44, 43, 44, 45, 126,    -- 4
    81, 82, 83, 84, 83, 84, 85, 86,    -- 5
    121,122,123,124,123,124,125,126,    -- 6
    161,162,163,164,163,164,165,166,    -- 7
    201,202,203,204,203,204,205,206,    -- 8
}
gMapWidth = 8
gMapHeight = 8

local gTopLeftTile = gMap[1]
local bottomRightTile = gMap[gMapWidth * gMapHeight] -- last

function GetTile(map, rowsize, x, y)
    x = x + 1   -- change from  1 -> rowsize
                -- to           0 -> rowsize - 1
    return map[x + y * rowsize]
end

local topLeftTile = GetTile(gMap, gMapWidth, 0, 0)
local bottomRightTile = GetTile(gMap, gMapWidth, gMapWidth - 1, gMapHeight - 1)

function update()
    for j = 0, gMapHeight - 1 do
        for i = 0, gMapWidth - 1 do
            local tile = GetTile(gMap, gMapWidth, i, j)
            local uvs = gUVs[tile]
            gTileSprite:SetUVs(unpack(uvs))

            gTileSprite:SetPosition(
                gLeft + i * gTileWidth,
                gTop - j * gTileHeight
            )
            gRenderer:DrawSprite(gTileSprite)
        end
    end
end