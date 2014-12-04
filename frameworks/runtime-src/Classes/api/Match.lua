
--------------------------------
-- @module Match
-- @parent_module yayoi

--------------------------------
-- 
-- @function [parent=#Match] fillDeck 
-- @param self
-- @param #int team
-- @param #map_table freq
        
--------------------------------
-- 
-- @function [parent=#Match] getCol 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Match] getRow 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Match] getDeck 
-- @param self
-- @param #int team
-- @return std::list<Chip , std::allocator<Chip > >#std::list<Chip , std::allocator<Chip > > ret (return value: std::list<yayoi.Chip , std::allocator<yayoi.Chip > >)
        
--------------------------------
-- 
-- @function [parent=#Match] getCastle 
-- @param self
-- @param #int team
-- @return std::pair<int, int>#std::pair<int, int> ret (return value: std::pair<int, int>)
        
--------------------------------
-- 
-- @function [parent=#Match] applyChip 
-- @param self
-- @param #yayoi.Piece target
-- @param #int idx
-- @return ActionResult#ActionResult ret (return value: yayoi.ActionResult)
        
--------------------------------
-- 
-- @function [parent=#Match] getPieces 
-- @param self
-- @return array_table#array_table ret (return value: array_table)
        
--------------------------------
-- 
-- @function [parent=#Match] wonTeam 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Match] calcDamage 
-- @param self
-- @param #yayoi.Piece from
-- @param #yayoi.Piece to
-- @return int#int ret (return value: int)
        
--------------------------------
-- @overload self, int, array_table, int, int, map_table         
-- @overload self         
-- @function [parent=#Match] Match
-- @param self
-- @param #int seed
-- @param #array_table pieces
-- @param #int row
-- @param #int col
-- @param #map_table freq

return nil
